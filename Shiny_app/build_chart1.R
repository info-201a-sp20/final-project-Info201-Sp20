library(plotly)
library(dplyr)
library(tidyr)
library(RColorBrewer)

# Takes a charts dataframe. Returns a plot showing the relationship between
# year and a genre's frequency.
plot_genre_trends <- function(df, input) {
  non0_genres <- df %>%
    group_by(year, genre) %>%
    summarize(times = n())

  with_zeros <- non0_genres %>%
    spread(genre, times, fill = 0) %>%
    gather(genre, times, -year)
 
  filtered <- with_zeros %>%
    filter(year >= input$year[1], year <= input$year[2])
  filtered$times <- filtered$times * 10

  fig <- plot_ly(filtered, x = ~year, y = ~times, type = "scatter",
                  mode = "line", color = ~genre, colors = colorRampPalette(
                    brewer.pal(5, "Dark2"))(20)) %>%
    layout(title = "Frequency of Genres Appearing Each Year - Top 10 Artists",
           xaxis = list(title = "Year"), yaxis = list(
             title = "Frequency (Percentage)"))
  return(fig)
}
