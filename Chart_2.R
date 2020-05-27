library(ggplot2)
library(GGally)
library(viridis)
library(tidyr)

source("get_genre_data.r")

get_top_10_genres <- function(genre_chart){
  ggplot(data=genre_chart, aes(x=year, y=times, color=genre)) +
    geom_line(size=1.3) +
    geom_point(size=2) +
    expand_limits(x=c(2000, 2020), y=c(1,10))
}
  
## Shows how many times a genre appears in a year (no "0" vals)
non0_genres <- chart %>% 
  group_by(year, genre, .drop = FALSE) %>% 
  summarize(times = n())

with_zeros <- non0_genres %>% 
  spread(genre, times, fill=0) %>% 
  gather(genre, times, -year) %>% 

# get_top_10_genres(with_zeros)

