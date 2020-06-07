library(plotly)
library(dplyr)
library(tidyr)
library(RColorBrewer)

chart <- read.csv("Data/top_10_charts.csv", stringsAsFactors = F)

non0_genres <- chart %>%
  group_by(year, genre) %>%
  summarize(times = n())

with_zeros <- non0_genres %>%
  spread(genre, times, fill=0) %>%
  gather(genre, times, -year)

plot <- plot_ly(with_zeros, x=~year, y=~times, type="scatter", mode="line",
                color=~genre, colors = colorRampPalette(brewer.pal(5,"Dark2"))(20))
plot
