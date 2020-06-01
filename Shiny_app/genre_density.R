
# Load relevant libraries
library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)

setwd("C:/Users/Abi/Desktop/final project/final-project-Info201-Sp20")

# Read in genre data
genredf <- read.csv('Data/charts_w_genres.csv', stringsAsFactors = FALSE)

#Subset data frame in order to show only genre and number of artists in
# defined genre
genredf_stripped <- subset(genredf, select = -c(year, position, song,
                                                indicativerevenue, X)) %>% 
    group_by(genre) %>%
    summarize(num_artist = n())

# Define UI 
ui <- fluidPage(
    titlePanel("Top Artist Genre Density"),
    sidebarLayout(
        sidebarPanel(
            # Orginally used selectizeInput() but selectInput appears to work
            # fine now. Haven't tried to troubleshoot with selectInput() yet.
            selectInput("genre",label = "Choose genres to display:",
                               choices = genredf_stripped$genre, multiple = T),
        ),
        mainPanel(
            mainPanel(plotlyOutput("PiePlot"))
        )
    )
)


#Define Server

#User input genre request. Not implemented, having issues with recognizing proper
# input and output. filter function doesn't work anyways but it was my attempt

#outputartist <- genredf_stripped %>% 
    #filter(~input$genre) %>% 
    #pull(num_artist)

server <- server <- function(input, output, session) {
    output$PiePlot <- renderPlotly({
        user_selections <- genredf_stripped %>% 
            subset(genre %in% input$genre)
        
        #Pie Chart
        PiePlot <- plot_ly(user_selections, labels = ~genre, values = ~num_artist,
                           type = 'pie') %>%
            layout(title = 'Top Artist Genre Density',
                   xaxis = list(showgrid = FALSE, zeroline = FALSE,
                                showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE,
                                showticklabels = FALSE))
        
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
