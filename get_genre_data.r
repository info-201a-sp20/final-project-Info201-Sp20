# Load in libraries
library(dplyr)
library(spotifyr)

# Clear environment every time we source the file
rm(list = ls())

# Source the analysis file for the data computed
source("analysis.R")

# Get the authentication key to use the API
key <- get_spotify_access_token(client_id ='f423590263fc48139f0d4d5f13d8e0d9',
                                client_secret = '8b32c38883eb47748570278fa4b063fd')

# "The Black Eyed Peas" doesn't show up in Spotify search results (which is weird)
# but it works when we remove the "The"
top_artists[4, "artist"] <- sub("The Black Eyed Peas", "Black Eyed Peas",
                                top_artists[4, "artist"])

# Returns a list where the keys are the artist name, values are the genre.
# The function only returns the first genre that Spotify spits out (it spits
# out more than one)
# I'm thinking we can some how extract the common ones (pop, rock, etc) from
# what we get, but I'm not sure how to do that yet. This is a start though!!

get_artist_genre <- function(df, key) {
  artists <- pull(df, artist)
  artist_genres = list()
  for (i in 1:length(artists)) {
    artist_id <- search_spotify(artists[i], type = "artist", authorization = key) %>%
      filter(row_number() == 1) %>%
      pull(id)

    artist_genre <- get_artist(artist_id,
                                   authorization = key)$genre[1]
    artist_name <- artists[[i]]
    artist_genres[[artist_name]] <- artist_genre
  }
  return(artist_genres)
}


top_artist_genres <- get_artist_genre(top_artists, key)

# This doesn't work yet. I suspect it has to do with the fact that spotify_search
# doesn't know what searching for more than 1 artist at a time means.

# top_yearly_genres <- get_artist_genre(top_artist_yearly, key)


