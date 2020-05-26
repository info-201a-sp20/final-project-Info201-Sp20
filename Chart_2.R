library(ggplot2)
library(GGally)
library(viridis)

source("get_genre_data.r")

get_top_10_genres <- function(genre_chart){
  ggplot(data=genre_chart, aes(x=year, y=SUM(GENRE), group=genre)) +
    geom_line()+
    geom_point()
}
  
colnames(chart)
genre_ct_col <- chart %>%
  group_by(year) %>%
  summarise(genre_ct = n())

new_chart = chart
new_chart$genre_ct <- genre_ct_col

test <- get_top_10_genres(new_chart)
test

