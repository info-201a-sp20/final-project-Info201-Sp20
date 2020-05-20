#Final project

chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv", stringsAsFactors = FALSE)





top_artist_yearly <- chart_2000 %>% 
  filter(position == 1) %>%
  group_by(year) %>% 
  summarise(artist = artist)

top_artists <- chart_2000 %>% 
  group_by(artist) %>%
  count() %>% 
  arrange(-n) %>% 
  head(10)

 
