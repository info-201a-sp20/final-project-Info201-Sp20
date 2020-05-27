library(ggplot2)
library(tidyr)

source("get_genre_data.r")

get_top_10_genres <- function(genre_chart){
  ggplot(data=genre_chart, aes(x = year, y = times, color = genre)) +
    geom_line(size=1.3) +
    geom_point(size=2) +
    expand_limits(x=c(2000, 2020), y=c(1,10)) +
    labs(title = "Number of Top 10 Hits per Genre by Year From 2000 - 2020"
         , x = "Year", y = "Number of Hits", color = "Genres")
}
  
## Shows how many times a genre appears in a year (no "0" vals)
non0_genres <- chart %>% 
  group_by(year, genre) %>% 
  summarize(times = n())

with_zeros <- non0_genres %>% 
  spread(genre, times, fill=0) %>% 
  gather(genre, times, -year) %>%
  filter(genre != "country",
         genre != "big room", 
         genre != "boy band",
         genre != "crunk",
         genre != "complextro",
         genre != "dance",
         genre != "electro",
         genre != "funk",
         genre != "irish singer-songwriter",
         genre != "permanent wave")

get_top_10_genres(with_zeros)

