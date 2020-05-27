<<<<<<< HEAD
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

=======
# Takes a charts dataframe. Returns a graph of top songs per year and how much 
# they made each year.
get_money_for_topsongs <- function(topsongs_year) {
 plot_money <- ggplot(topsongs_year, aes(x= factor(year),
                            y= indicativerevenue)) +
    geom_segment(aes(xend= factor(year), yend= 0, colour = song)) +
    geom_point(size=4, color = "orange") +
    labs(title = "Indicative Revenue per Top Song from 2012 to 2020",
         x = "Year", y = "Indicative Revenue (US Dollars)") +
    guides(colour = guide_legend(title = "Songs")) +
    xlab("")
  return(plot_money)
<<<<<<< HEAD
} 
<<<<<<< HEAD
>>>>>>> 7295b4120887a5cdbd08f7025b59bbe4aef9eb97
=======

=======
>>>>>>> 767e745edbda1a9468e95169ec1439a4c892a446

} 


>>>>>>> 2eb7566f8332d278adb3e9a2d9695b3f988b271c
