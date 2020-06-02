# TOP ARTIST GENRE DENSITY
# Takes in genre(s) and generates a pie chart showing how many artists belong
# in each genre and how they compare to other genres.

# Load relevant libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

# Read in genre data
genredf <- read.csv("../Data/charts_w_genres.csv", stringsAsFactors = FALSE)

# Subset data frame in order to show only genre and number of artists in
# defined genre
genredf_stripped <- subset(genredf, select = -c(year, position, song,
                                                indicativerevenue, X)) %>%
    group_by(genre) %>%
    summarize(num_artist = n())

p_tag_style <- 
    "border-radius: 10px;
   padding: 10px 20px 10px 20px;
   background-color: #f5f5f5;
   "

# Define UI
ui <- fluidPage(
    titlePanel("Genre Density: Which Genres Do Top Artists Belong To?"),
    sidebarLayout(
        sidebarPanel(
            selectInput("genre", label = "Choose genres to display:",
                               choices = genredf_stripped$genre, multiple = T),
            h4(align = "center", "Analysis"),
            p(style = p_tag_style,
            strong("This chart attempts to show the
            differences in genre density. Genre density is defined by the
            amount of top artists from 2000 - 2020 in each genre."),
            "Being able to compare popular genres (genres with a large number
            of top artists) with less popular genres can shed light on what
            genres are more likely to become popular in a population.
            Additionally, this information can show cultural music
            preferences for the time period. Besides cultural speculations,
            the information may influence what genre an upcoming artist
            may aim to be associated with in order to gain popularity.
            *note: Not all existing genres will be included in the drop-down.
            Only genres associated with the top artists from 2000 - 2020 are
            listed.
            ")
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
                               "<br><b># of Artists:</b>","%{value}",
                               "<extra></extra>"))  %>%
            layout(title = "Amount of Artists in Each Genre",
                   xaxis = list(showgrid = FALSE, zeroline = FALSE,
                                showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE,
                                showticklabels = FALSE))
    })
}
# Run the application
shinyApp(ui = ui, server = server)
