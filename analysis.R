#Final project

# Load in our library
library(dplyr)

# This clears the environment every time you source, just to keep things clean
rm(list = ls())

# get the data
chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv", stringsAsFactors = FALSE)

# Calculate top artists (position 1) each year
# Returns a data frame
top_artist_yearly <- chart_2000 %>% 
  filter(position == 1) %>%
  select(year, artist)

# Calculates top 10 artists who appeared on the charts the most
# Returns a data frame
top_artists <- chart_2000 %>% 
  group_by(artist) %>%
  count() %>% 
  arrange(-n) %>% 
  head(10)







 
