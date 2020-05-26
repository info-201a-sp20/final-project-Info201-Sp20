library(ggplot2)
library(dplyr)
chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv",
                       stringsAsFactors = FALSE)

# Takes a charts dataframe. Returns a graph of top songs per year and how much 
# they made each year.
get_money_for_topsongs <- function(topsongs_year){
  plot_money <- ggplot(topsongs_year, aes(x= factor(year),
                                          y= indicativerevenue)) +
    geom_segment(aes(xend= factor(year), yend= 0, colour = song)) +
    geom_point(size=4, color = "orange") +
    labs(title = "Indicative Revenue per Top Song from 2012 to 2020",
         x = "Year", y = "Indicative Revenue (US Dollars)") +
    guides(colour = guide_legend(title = "Songs")) +
    xlab("")
  return(plot_money)
} 


# Top songs of each year 
song_revenue_position_df <- subset(chart_2000, select = -c(artist, us, uk,
                                                           de, fr, ca, au))

topsongs_year <- song_revenue_position_df %>% 
  filter(position == 1) %>% 
  filter(year > 2011) %>% 
  subset(select = -c(position))

plot_topsongs <- get_money_for_topsongs(topsongs_year)
plot_topsongs

