source("get_genre_data.r")

# Takes a charts dataframe. Returns a plot showing the relationship between
# genre popularity and time.
get_top_10_genres <- function(genre_chart){
  plot <- ggplot(data=genre_chart, aes(x = year, y = times, color = genre)) +
    geom_line(size=1.3) +
    geom_point(size=2) +
    expand_limits(x=c(2000, 2020), y=c(1,10)) +
    labs(title = "Number of Top 10 Hits per Genre by Year From 2000 - 2020"
         , x = "Year", y = "Number of Hits", color = "Genres")
  return(plot)
}

