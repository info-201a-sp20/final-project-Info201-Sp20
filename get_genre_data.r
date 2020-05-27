# This script contains helper functions used to get genre information for our
# main data set. This entire script is used as a helper for 'Chart_2.R' and is
# NOT meant to be counted as one of the 5 scripts written for the assignment.
# The data needs to be passed into this script because this script is
# responsible for creating the data frame that Chart_2.R plots.

# Load in libraries
library(dplyr)
library(spotifyr)
library(stringr)
library(devtools)
install_github("charlie86/spotifyr")

# Clear environment every time we source the file
rm(list = ls())

# Get the data
chart <- read.csv("data/chart2000-songyear-0-3-0058.csv", stringsAsFactors =
                    FALSE)

# Get the authentication key to use the API
cli_id <- "f423590263fc48139f0d4d5f13d8e0d9"
cli_secret <- "8b32c38883eb47748570278fa4b063fd"
key <- get_spotify_access_token(client_id = cli_id, client_secret = cli_secret)

# Getting the Raw Genres -----

# We need to replace the names that have more than 1 artist, and take everything
# before the "&" or the ","
# This just gives us the main artist to search for (which the search_spotify
#function likes)

# Takes in a string of artists, the character to stop at, and the respective
# offset for the character. Returns a new string that takes everything from the
# old string up to (and not including) the given character.
#
# If char is "&", offset is 2. If char is ",", offset is 1.
remove_str <- function(artist, char, offset) {
    sign_loc <- str_locate(artist, char)
  solo_artist <- str_sub(artist, 1, sign_loc[1] - offset)
  return(solo_artist)
}

# Takes a charts data frame. Returns a list of the top yearly artists WITHOUT
# the other featured artists
get_solo_artists <- function(df) {
  artists <- df$artist
  result <- list()
  for (i in seq(to = length(artists))) {
    if (str_detect(artists[i], "&") &&
        str_detect(artists[i], ",")) {
      no_ampersand <- remove_str(artists[i], "&", 2)
      solo_artist <- remove_str(no_ampersand, ",", 1)
      result[i] <- solo_artist
    } else if (str_detect(artists[i], "&")) {
      solo_artist <- remove_str(artists[i], "&", 2)
      result[i] <- solo_artist
    } else {
      result[i] <- artists[i]
    }
  }
  return(result)
}

# Takes a charts dataframe, the name of the column that contains the artists,
# and the API authentication key. Returns a list where the values are the genre.
# The order of this list follows the order of the artists in the given
# data frame.
get_artist_genre <- function(df, artist_col, key) {
  artists <- pull(df, as.name(artist_col))
  artist_genres <- list()
  for (i in seq(to = length(artists))) {
    artist_id <- search_spotify(artists[[i]], type = "artist",
                                authorization = key) %>%
        filter(row_number() == 1) %>%
        pull(id)
    artist_genre <- get_artist(artist_id, authorization = key)$genre[1]
    if (typeof(artist_genre) != "list") {
      artist_genres[[i]] <- artist_genre
    } else {
      artist_genre[[i]] <- "zero"
    }
  }
  return(artist_genres)
}

# Getting the Main Genres -----

# Now we want to extract all of the main genres (pop, rock, hip hop, etc) from
# the ones that we got. Since a lot of them are variations of (for example) pop,
# we'll put them all under the umbrella term "pop". This will make it easier to
# plot and show the trends.

# These are the common genres across that appeared
# There are other, unique genres (eg: electropop, boy band) that also appeared,
# but did not need to be put into an umbrella catergory.
common_genres <- list("pop", "rock", "hip hop", "dance", "soul", "rap", "metal",
                      "country", "r&b", "latin", "mellow",
                      "funk")
pattern <- paste(common_genres, collapse = "|")

# Takes a list with the "raw" genres. Returns a list where the values are the
# common genres.
get_common_genres <- function(genre_list) {
  result <- list()
  for (i in seq(to = length(genre_list))) {
    for (common_gen in common_genres) {
      # We first check to make sure the value is not NULL, and then if it
      # contains one of our common genres
      if (length(genre_list[[i]]) != 0 && grepl(common_gen, genre_list[[i]])) {
        result[[i]] <- common_gen
        break
      } else {
        # The genre was either NULL, or was one of the unique genres
        result[[i]] <- genre_list[[i]]
      }
    }
  }
  return(result)
}

# Filter down to the data we want
chart <- chart %>%
  filter(position == 1:10) %>%
  select(year, artist, position)

# get the list of artists without the features
artists_no_feature <- get_solo_artists(chart)

# Add a new column which represents just the main artist without
# featured artists
chart <- mutate(chart, artists_wo_feature = artists_no_feature)

# Get the genres based on the main artist in the song
top_genres <- get_artist_genre(chart, "artists_wo_feature", key)

# Replace that with the list of common genres
top_genres <- get_common_genres(top_genres)

# Remove the rows that have NULL values for genre
chart <- chart[-c(35, 37, 60, 92, 93), ]

# Create a new column with our genre information. This is the data frame
# that Chart_2.r will use to plot.
chart <- mutate(chart, genre = unlist(top_genres))
