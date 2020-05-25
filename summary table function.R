
# Takes in the data. Returns a table with the top artists of each year
# between 2000-2020, sorted in decending order.

chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv", stringsAsFactors = FALSE)


chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv", stringsAsFactors = FALSE)

summary_table_function <- function(df){
  
  top_artist_yearly <- df %>% 
    filter(position == 1) %>%
    group_by(year) %>% 
    summarise(artist = artist) %>% 
    arrange(-year)
    
  return(top_artist_yearly)
}


df <- chart_2000

summary_table <- summary_table_function(df)
 
summary_table

summary_table <- summary_table_function(df)

