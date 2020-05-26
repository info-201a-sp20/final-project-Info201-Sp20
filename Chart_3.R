# Clear Global Environment
rm(list = ls())

# Library Functions 
library(ggplot2)
library(lintr)
library("dplyr")

# Original data frame 
chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv",
                       stringsAsFactors = FALSE)

# Data frame of the songs, position and revenue 
song_revenue_position_df <- subset(chart_2000, select = -c(artist, us, uk,
                                             de, fr, ca, au))
# Top songs of each year 
topsongs_year <- song_revenue_position_df %>% 
  filter(position == 1) %>% 
  filter(year > 2011) %>% 
  subset(select = -c(position))

topsongs_year

# graph of top songs per year and how much they made each year 
money_for_topsongs <- ggplot(topsongs_year) +
  geom_bar(mapping = aes(x = factor(year), y = indicativerevenue,
                         group = song, fill = song),
           position = "dodge", stat = "identity") +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Indicative Revenue per Top Song from 2012 to 2020",
       x = "Year", y = "Indicative Revenue") +
  guides(fill = guide_legend(title = "Songs"))

money_for_topsongs

