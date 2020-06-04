library(shiny)
library(ggvis)
library(dplyr)
library(tidyr)
library(ggplot2)

## DELETE THIS! DELETE THIS! DELETE THIS! DELETE THIS! DELETE THIS! DELETE THIS!

chart_10s <- read.csv("Data/top_10_charts.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Genre Explorer"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            wellPanel(
               h4("Filter"),
               #changed label
               sliderInput("genre", label = "Max number of hits:",
                           0, 10, 2, step = 1),
               sliderInput("year", label = "Number of years without Top 10 hits:",
                           0, 20, value = c(2, 8)),
            ),
            wellPanel(
               selectInput("year", "X-axis variable", chart_10s$year, selected = "Year"),
               selectInput("hits", "Y-axis variable", chart_10s$position, selected = "Hits"),
               tags$small(paste0(
                   "Note: ~~~")
                   )
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("genre_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Filter data
  #non0_genres <- chart_10s %>%
   # group_by(input$year, input$genre) %>%
   # summarize(times = n())
  with_zeros <- non0_genres %>%
    spread(genre, times, fill=0) %>%
    gather(genre, times, -year)

  
  output$distPlot <- renderPlot({
    ggplot(with_zeros, aes(x=year, y=times)) +
      geom_point(size=2, shape=23)
})
}

# Run the application 
shinyApp(ui = ui, server = server)
