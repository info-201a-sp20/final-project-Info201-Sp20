chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv",
                       stringsAsFactors = FALSE)

library(ggplot2)
library(lintr)

stripped_df <- subset(chart_2000, select = -c(indicativerevenue, song, us, uk,
                                              de, fr, ca, au))
filtered_df <- subset(stripped_df, artist %in% c("Rihanna", "Pink", "Maroon 5",
                                                 "The Black Eyed Peas",
                                                 "Taylor Swift")) %>%
  group_by(artist, year) %>%
  summarise(number_of_hits = n())


top5_num_hits <- ggplot(filtered_df) +
  geom_bar(mapping = aes(x = factor(year), y = number_of_hits,
                         group = artist, fill = artist),
           position = "dodge", stat = "identity") +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Number of Hits The Top 5 Artists of 2000 - 2020 Had Yearly",
       x = "Year", y = "Number of Hits") +
  guides(fill = guide_legend(title = "Artist"))
top5_num_hits
