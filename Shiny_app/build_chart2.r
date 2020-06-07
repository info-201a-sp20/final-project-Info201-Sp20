library(dplyr)
library(plotly)

# Helper functions
source("Shiny_app/get_solo_artist.r")

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
count_num_hits <- function(df) {
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
    top_num_hits <- sample_n(top_num_hits, 15)
  }

  artists <- top_num_hits$solo_artist
  artist_genres <- list()
  for (i in seq(length(artists))) {
    genre <- data %>%
      filter(solo_artist == as.name(artists[[i]])) %>%
      head(1) %>%
      pull(genre)
    artist_genres[[i]] <- genre
  }
  top_num_hits <- mutate(top_num_hits, genre = unlist(artist_genres))
  names(top_num_hits)[1] <- "Artist"
  names(top_num_hits)[2] <- "Number of Hits"
  names(top_num_hits)[3] <- "Genre"
  return(top_num_hits)
}

# Takes in a number of hits table, and the number of hits. Returns a bar chart
# showing the frequency of each genre in the given table.
plot_genre_frequency <- function(table, num_hits) {
  plot_table <- table %>%
    group_by(Genre) %>%
    summarize(frequency = n())

  fig <- plot_ly(data = plot_table, x = ~Genre, y = ~frequency, type = "bar")
  fig <- fig %>%
    layout(title = paste0("Frequency of Genres for Artists with ",
                           num_hits, " Hits"),
           yaxis = list(title = "Frequency"),
           xaxis = list(tickangle = 45))
  return(fig)
}
