library(shiny)
library(plotly)
library(dplyr)
library(tidyr)
library(RColorBrewer)

chart <- read.csv('Data/top_10_charts.csv', stringsAsFactors = F)

non0_genres <- chart %>%
    group_by(year, genre) %>%
    summarize(times = n())

with_zeros <- non0_genres %>%
    spread(genre, times, fill=0) %>%
    gather(genre, times, -year)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel('Genres by Top 10 Hits'),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput('year', 'Year released:',
                        min(with_zeros$year), max(with_zeros$year),
                        value = c(min(with_zeros$year), max(with_zeros$year)),
                        step = 1,
                        sep = ''
            ),
            
            sliderInput('hits', 'Least/most number of hits:',
                        min(with_zeros$times), max(with_zeros$times),
                        value = c(min(with_zeros$times), max(with_zeros$times)),
                        step = 1,
                        sep = ''
            ),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput('line')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$line <- renderPlotly({
        filtered <- with_zeros %>% 
            filter(year >= input$year[1], year <= input$year[2],
                   times >= input$hits[1], times <= input$hits[2])
        
        fig <- plot_ly(filtered,
                       x=~year,
                       y=~times,
                       type="scatter", mode="line",
                       color=~genre,
                       colors = colorRampPalette(brewer.pal(5,"Dark2"))(20))
        fig
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
