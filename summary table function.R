
summary_table_function <- function(df){
  
  top_artist_yearly <- df %>% 
    filter(position == 1) %>%
    group_by(year) %>% 
    summarise(artist = artist) %>% 
    arrange(-year)
    
  return(top_artist_yearly)
  
}
df <- chart_2000
summary_table_function(df)
