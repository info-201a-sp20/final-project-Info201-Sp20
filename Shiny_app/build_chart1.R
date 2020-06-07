library(plotly)
library(dplyr)
library(tidyr)
library(RColorBrewer)

# Takes a charts dataframe. Returns a plot showing the relationship between
# year and a genre's frequency.
plot_genre_trends <- function(df) {
  non0_genres <- df %>%
    group_by(year, genre) %>%
    summarize(times = n())

  with_zeros <- non0_genres %>%
    spread(genre, times, fill = 0) %>%
    gather(genre, times, -year)

  fig <- plot_ly(with_zeros, x = ~year, y = ~times, type = "scatter",
                  mode = "line", color = ~genre, colors = colorRampPalette(
                    brewer.pal(5, "Dark2"))(20)) %>%
    layout(title = "Frequency of Genres Appearing Each Year - Top 10 Artists",
           xaxis = list(title = "Year"), yaxis = list(
             title = "Frequency (Percentage)"))
  return(fig)
}
