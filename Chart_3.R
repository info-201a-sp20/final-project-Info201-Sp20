# Takes a charts dataframe. Returns a graph of top songs per year and how much 
# they made each year.
get_money_for_topsongs <- function(topsongs_year){
  plot_money <- ggplot(topsongs_year) +
    geom_bar(mapping = aes(x = factor(year), y = indicativerevenue,
                           group = song, fill = song),
             position = "dodge", stat = "identity") +
    scale_fill_brewer(palette = "Set1") +
    labs(title = "Indicative Revenue per Top Song from 2012 to 2020",
         x = "Year", y = "Indicative Revenue") +
    guides(fill = guide_legend(title = "Songs"))
  return(plot_money)
} 
