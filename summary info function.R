# Takes in the data and the column of interest. Returns info about the
# highest total revenue made by an artist.
get_artist_revenue <- function(df, col) {
  result <- df %>% 
    group_by(artist) %>%
    summarise(revenue = sum(indicativerevenue)) %>%
    filter(revenue == max(revenue, na.rm = TRUE)) %>%
    pull(as.name(col))
  if (typeof(result) == "double") {
    result <- round(result)
  }
  return(result)
}

# Takes in the data, the column of interest, and a min/max function. Returns
# info about the song earning the most/least revenue in one year.
get_song_revenue <- function(df, col, fun) {
  result <- df %>% 
    filter(indicativerevenue == match.fun(fun)(indicativerevenue)) %>%
    pull(as.name(col))
  if (typeof(result) == "double") {
    result <- round(result)
  }
  return(result)
}

# Takes in the data and the column of interest. Returns info about the
# artist who appeared the most number of times.
get_artist_most_appeared <- function(df, col) {
  result <- df %>% 
    group_by(artist) %>%
    count() %>%
    arrange(-n) %>%
    head(1) %>%
    pull(as.name(col))
  return(result)
}

# Takes in the data. Returns a list where the keys describe the values, and
# the values are summary pieces about the dataset.
get_summary_info <- function(df){

  artist_most_revenue <- get_artist_revenue(df, "artist")
  artist_revenue_total <- get_artist_revenue(df, "revenue")
  
  song_most_revenue <- get_song_revenue(df, "song", "max")
  song_most_revenue_year <- get_song_revenue(df, "year", "max")
  
  artist_most_appeared <- get_artist_most_appeared(df, "artist")
  times_artist_appeared <- get_artist_most_appeared(df, "n")
  
  song_least_revenue <- get_song_revenue(df, "song", "min")
  
  song_most_appeared <- df %>% 
    group_by(song) %>% 
    count() %>% 
    arrange(-n) %>% 
    head(2) %>% 
    pull(song)
  
  my_list <- list("Artist with the most total revenue" = artist_most_revenue,
                  "Artist's total revenue" = artist_revenue_total,
                  "Song with the most revenue in one year" = song_most_revenue,
                  "Year that occured" = song_most_revenue_year,
                  "Artist who appeared the most times" = artist_most_appeared,
                  "Times they appeared" = times_artist_appeared,
                  "Song with the least revenue in one year" = 
                   song_least_revenue,
                  "Song that appeared the most times" = song_most_appeared)
  
  return(my_list)
}

