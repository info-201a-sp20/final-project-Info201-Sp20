# Takes a charts dataframe. Returns a graph of top songs per year and how much
# they made each year.
get_money_for_topsongs <- function(topsongs_year) {
 plot_money <- ggplot(topsongs_year, aes(x = factor(year),
                            y = indicativerevenue)) +
    geom_segment(aes(xend = factor(year), yend = 0, colour = song)) +
    geom_point(size = 4, color = "orange") +
    labs(title = "Indicative Revenue per Top Song from 2012 to 2020",
         x = "Year", y = "Indicative Revenue (US Dollars)") +
    guides(colour = guide_legend(title = "Songs")) +
    xlab("")
  return(plot_money)
}
