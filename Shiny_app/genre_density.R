# TOP ARTIST GENRE DENSITY
# Takes in genre(s) and generates a pie chart showing how many artists belong
# in each genre and how they compare to other genres.

# Load relevant libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

# Read in genre data
genredf <- read.csv("Data/charts_w_genres.csv", stringsAsFactors = FALSE)

# Subset data frame in order to show only genre and number of artists in
# defined genre
genredf_stripped <- subset(genredf, select = -c(year, position, song,
                                                indicativerevenue, X)) %>%
    group_by(genre) %>%
    summarize(num_artist = n())

# Define UI
ui <- fluidPage(
    titlePanel("Genre Density: Which Genres Do Top Artists Belong To?"),
    sidebarLayout(
        sidebarPanel(
            selectInput("genre", label = "Choose genres to display:",
                               choices = genredf_stripped$genre, multiple = T),
            h4("Analysis"),
            p("Insert why this is significant data here")
        ),
        mainPanel(
            mainPanel(plotlyOutput("pieplot"))
        )
    )
)

#Define Server
server <- function(input, output, session) {
    output$pieplot <- renderPlotly({
        # Retrieve user input from shiny widget
        user_selections <- genredf_stripped %>%
            subset(genre %in% input$genre)
        # Pie Chart visual formatting
        font <- list(
            size = 15,
            color = "white"
        )
        label <- list(
            bgcolor = "#232F34",
            bordercolor = "transparent",
            font = font
        )

        # Pie Chart
        pieplot <- plot_ly(user_selections,
                           labels = ~genre,
                           values = ~num_artist,
                           type = "pie",
                           hoverlabel = label,
                           hovertemplate = paste(
                               "<b>Percent: </b>%{percent}",
                               "<br><b># of Artists:</b>",
                               "%{value}<br>",
                               "<extra></extra>"))  %>%
            layout(title = "Top Artist Density in Genre Categories",
                   xaxis = list(showgrid = FALSE, zeroline = FALSE,
                                showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE,
                                showticklabels = FALSE))
    })
}
# Run the application
shinyApp(ui = ui, server = server)
