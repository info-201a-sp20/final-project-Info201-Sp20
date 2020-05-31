library(dplyr)

rm(list = ls())

source("get_solo_artist.r")
chart <- read.csv("data/charts_w_genres.csv", stringsAsFactors = FALSE)

# Takes the main charts dataset. Returns a new dataset with the solo artist
# column attached.
add_solo_artists <- function(main_df) {
  solo_artists <- get_solo_artists(main_df)
  # adds column of the Solo Artist, no feature
  main_df <- mutate(main_df, solo_artist = unlist(solo_artists))
  return(main_df)
}


# Takes in the charts dataframe WITH solo artist column. Returns a new dataframe
#that contains artist and number of hits they had.
count_num_hits <- function(df){
  df_new <- add_solo_artists(df)
  times_appeared <- df_new %>% 
    group_by(solo_artist) %>% 
    summarize(num_hits = n())
  return(times_appeared)
}


# Takes a number of hits, a filtered (artist + number of hits) dataframe, and
# the main charts dataframe. Returns a dataframe with the artist column, 
# number of hits column matching given param, and their respective genre.
make_hits_table <- function(num, filtered, data) {
  # this is times
  top_num_hits <- filtered %>% 
    filter(num_hits == num)
  
  if (as.integer(num) <= 5) {
    top_num_hits <- sample_n(top_num_hits, 20)
  }
  
  artists <- top_num_hits$solo_artist
  artist_genres <- list()
  for (i in seq(length(artists))) {
    genre <- data %>% # this is from read.csv
      filter(solo_artist == as.name(artists[[i]])) %>% 
      head(1) %>% 
      pull(genre)
    artist_genres[[i]] <- genre
  }
  top_num_hits <- mutate(top_num_hits, genre = artist_genres)
  names(top_num_hits)[1] <- "Artist"
  names(top_num_hits)[2] <- "Number of Hits"
  names(top_num_hits)[3] <- "Genre"
  return(top_num_hits)
}





