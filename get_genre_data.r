# Load in libraries
library(dplyr)
library(spotifyr)
library(stringr)

# Clear environment every time we source the file
rm(list = ls())

# Source the analysis file for the data computed
source("analysis.R")

# Get the authentication key to use the API
cli_id <- "f423590263fc48139f0d4d5f13d8e0d9"
cli_secret <- "8b32c38883eb47748570278fa4b063fd"
key <- get_spotify_access_token(client_id = cli_id, client_secret = cli_secret)

# "The Black Eyed Peas" doesn't show up in Spotify search results
#(which is weird) but it works when we remove the "The"
top_artists[4, "artist"] <- sub("The Black Eyed Peas", "Black Eyed Peas",
                                top_artists[4, "artist"])

# Returns a list where the keys are the artist name, values are the genre.
# The function only returns the first genre that Spotify spits out (it spits
# out more than one)
# I'm thinking we can some how extract the common ones (pop, rock, etc) from
# what we get, but I'm not sure how to do that yet. This is a start though!
get_artist_genre <- function(df, artist_col, key) {
  artists <- pull(df, as.name(artist_col))
  artist_genres <- list()
  for (i in 1:length(artists)) {
    artist_id <- search_spotify(artists[[i]], type = "artist",
                                authorization = key) %>%
      filter(row_number() == 1) %>%
      pull(id)
    artist_genre <- get_artist(artist_id, authorization = key)$genre[1]
    artist_name <- artists[[i]]
    artist_genres[[artist_name]] <- artist_genre
  }
  return(artist_genres)
}

top_artist_raw_genres <- get_artist_genre(top_artists, "artist", key)


# Need to replace the names that have more than 1 artist, and take everything
# before the "&" or the ","
# This just gives us the main artist to search for (which the search_spotify
#function likes)

# Returns a new string, which takes everything from the old string up to (not
# including) the ","
remove_comma <- function(artist) {
  sign_loc <- str_locate(artist, ",")
  fixed_artist <- str_sub(artist, 1, sign_loc[1] - 1)
  return(fixed_artist)
}

# Returns a new string, which takes everything from the old string up to (not
# including) the "&"
remove_ampersand <- function(artist) {
  sign_loc <- str_locate(artist, "&")
  fixed_artist <- str_sub(artist, 1, sign_loc[1] - 2)
  return(fixed_artist)
}

# Returns a list of the top yearly artists WITHOUT the other featured artists
get_yearly_artists_no_feature <- function(top_artist_yearly) {
  yearly_artists <- top_artist_yearly$artist
  result <- list()
  for (i in 1:length(yearly_artists)) {
    if (str_detect(yearly_artists[i], "&") &&
        str_detect(yearly_artists[i], ",")) {
      no_ampersand <- remove_ampersand(yearly_artists[i])
      fixed_artist <- remove_comma(no_ampersand)
      result[i] <- fixed_artist
    } else if (str_detect(yearly_artists[i], "&")) {
      fixed_artist <- remove_ampersand(yearly_artists[i])
      result[i] <- fixed_artist
    } else {
      result[i] <- yearly_artists[i]
    }
  }
  return(result)
}

# get the list of artists without the features
artists_no_feature <- get_yearly_artists_no_feature(top_artist_yearly)

# Add a new column which represents just the main artist without
#featured artists
top_artist_yearly <- mutate(top_artist_yearly,
                            artists_wo_feature = artists_no_feature)

# Get the genres based on the main artist in the song
top_yearly_raw_genres <- get_artist_genre(top_artist_yearly, "artists_wo_feature",
                                      key)

# Now we want to extract all of the main genres (pop, rock, hip hop, etc) from
# the ones that we got. Since a lot of them are variations of (for example) pop,
# I think it's okay to put those all under the umbrella term "pop". This will
# make it easier to plot and show the trends.

# These are the common genres across the two lists
common_genres <- list("pop", "rock", "hip hop", "dance", "soul", "rap", "metal",
                      "country")
pattern <- paste(common_genres, collapse = "|")

# Takes a list with the "raw" genres. Returns a list where the key is the
# artist and the value is the common genre.
get_common_genres <- function(genre_list) {
  result <- list()
  for (artist in names(genre_list)) {
    for (common_gen in common_genres) {
      if(grepl(common_gen, genre_list[[artist]])) {
        result[[artist]] <- common_gen
        break
      }
    }
  }
  return(result)
}

# Get the genres for the top 10 artists
top_artist_genres <- get_common_genres(top_artist_raw_genres)

# Get the genres for the top yearly artists
top_yearly_genres <- get_common_genres(top_yearly_raw_genres)

