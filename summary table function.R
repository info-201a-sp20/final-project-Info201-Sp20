
# Takes in the data. Returns a table with the top artists of each year
# between 2000-2020, sorted in decending order.
get_summary_table <- function(df){
  
  top_artist_yearly <- df %>% 
    filter(position == 1) %>%
    group_by(year) %>% 
    summarise(artist = artist) %>% 
    arrange(-year)
    
  return(top_artist_yearly)
}
