# Chart_1 describes how many hits each of the top 5 artists from 2000-2020 had
# over time. A 'hit' is defined as a song that made it into the top 100 songs 
# of a given year.

# Original data frame is read in
chart_2000 <- read.csv("data/chart2000-songyear-0-3-0058.csv",
                       stringsAsFactors = FALSE)

# Load fucntions
library(ggplot2)
library(lintr)

# Irrelevant column data is removed
stripped_df <- subset(chart_2000, select = -c(indicativerevenue, song, us, uk,
                                              de, fr, ca, au))

# Data frame of number of hits the top 5 aritsts from 2000-2020 had
filtered_df <- subset(stripped_df, artist %in% c("Rihanna", "Pink", "Maroon 5",
                                                 "The Black Eyed Peas",
                                                 "Taylor Swift")) %>%
  group_by(artist, year) %>%
  summarise(number_of_hits = n())

# Bar graph displaying how many hits each top 5 artist had each year from 
# 2000 to 2020
top5_num_hits <- ggplot(filtered_df) +
  geom_bar(mapping = aes(x = factor(year), y = number_of_hits,
                         group = artist, fill = artist),
           position = "dodge", stat = "identity") +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Number of Hits The Top 5 Artists of 2000 - 2020 Had Yearly",
       x = "Year", y = "Number of Hits") +
  guides(fill = guide_legend(title = "Artist"))
top5_num_hits
