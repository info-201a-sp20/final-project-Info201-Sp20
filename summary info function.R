## Summary Information 

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

