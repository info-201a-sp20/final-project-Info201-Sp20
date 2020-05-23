#Final project

chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv", stringsAsFactors = FALSE)
library(dplyr)
library(gsubfn)

top_artist_yearly <- chart_2000 %>% 
  filter(position == 1) %>%
  group_by(year) %>% 
  summarise(artist = artist)
  

top_artists_appeard <- chart_2000 %>% 
  group_by(artist) %>%
  count() %>% 
  arrange(-n) %>% 
  head(10)


#summary shit

artist_most_revenue <- chart_2000 %>% 
  group_by(artist) %>% 
  summarise(revenue = sum(indicativerevenue)) %>% 
  filter(revenue == max(revenue)) %>% 
  pull(artist)

song_most_revenue_in_one_year <- chart_2000 %>%
  filter(indicativerevenue == max(indicativerevenue)) %>% 
  pull(song)

artist_most_appeared <- chart_2000 %>% 
  group_by(artist) %>% 
  count() %>%
  arrange(-n) %>%
  head(1) %>% 
  pull(artist)

#trying to the same thing so it would work for every dataset, I can do this for 
  # other functions if thats what we feel is right. 

artist_most_start <- chart_2000 %>% 
  group_by(artist) %>% 
  count() %>%
  arrange(-n)
top <- artist_most_appeared1 %>% 
  head(1) %>% 
  pull(n)
artist_most_appeared1 <- artist_most_start %>% 
  filter(n == top) %>% 
  pull(artist)

#done above^

song_least_revenue_in_one_year <- chart_2000 %>% 
  filter(indicativerevenue == min(indicativerevenue)) %>% 
  pull(song)

song_most_appeared <- chart_2000 %>% 
  group_by(song) %>% 
  count() %>% 
  arrange(-n) %>% 
  head(2) %>% 
  pull(song)

#again, same thing that would work for other dataframes

song_most_appeared_start <- chart_2000 %>% 
  group_by(song) %>% 
  count() %>% 
  arrange(-n)
top1 <- song_most_appeared_start %>% 
  head(1) %>%
  pull(n)
song_most_appeared1 <- song_most_appeared_start %>% 
  filter(n == top1) %>% 
  pull(song)

#done above^
  
summary_function <- function(df){
  
  
  artist_most_revenue <- chart_2000 %>% 
    group_by(artist) %>% 
    summarise(revenue = sum(indicativerevenue)) %>% 
    filter(revenue == max(revenue)) %>% 
    pull(artist)
  
  song_most_revenue_in_one_year <- chart_2000 %>%
    filter(indicativerevenue == max(indicativerevenue)) %>% 
    pull(song)
  
  artist_most_appeared <- chart_2000 %>% 
    group_by(artist) %>% 
    count() %>%
    arrange(-n) %>%
    head(1) %>% 
    pull(artist)
  
  song_least_revenue_in_one_year <- chart_2000 %>% 
    filter(indicativerevenue == min(indicativerevenue)) %>% 
    pull(song)
  
  song_most_appeared <- chart_2000 %>% 
    group_by(song) %>% 
    count() %>% 
    arrange(-n) %>% 
    head(2) %>% 
    pull(song)
  
  
  my_list <- list("Artist with the most total revenue" = artist_most_revenue,
                 "Song wth the most revenue in one year" = song_most_revenue_in_one_year,
                 "Artist who appeared the most times" = artist_most_appeared,
                 "Song with the least revenue in one year" = song_least_revenue_in_one_year,
                 "Song that appeared the most times" = song_most_appeared)
  
  return(my_list)
}

df <- chart_2000
summary_function(df)

  
  
## sUMMARY fUNCTION 

summary_table_function <- function(df){
  
  top_artist_yearly <- df %>% 
    filter(position == 1) %>%
    group_by(year) %>% 
    summarise(artist = artist) %>% 
    arrange(-year)
  return(top_artist_yearly)
  
}

