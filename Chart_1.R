# Chart_1 describes how many hits each of the top 5 artists from 2000-2020 had
# over time. A 'hit' is defined as a song that made it into the top 100 songs 
# of a given year.


# Takes a charts dataframe. Returns a bar graph displaying how many hits each 
# top 5 artist had each year from 2000 to 2020
get_top5_num_hits <- function(filtered_df){
  plot_top5  <- ggplot(filtered_df) +
    geom_bar(mapping = aes(x = factor(year), y = number_of_hits,
                           group = artist, fill = artist),
             position = "dodge", stat = "identity") +
    scale_fill_brewer(palette = "Set1") +
    labs(title = "Number of Hits The Top 5 Artists of 2000 - 2020 Had Each Year"
         , x = "Year", y = "Number of Hits") +
    guides(fill = guide_legend(title = "Artist"))
  return(plot_top5)
} 

