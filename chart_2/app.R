library(shiny)

source("build_chart2.r")

chart <- read.csv("data/charts_w_genres.csv", stringsAsFactors = FALSE)
chart_with_solos <- add_solo_artists(chart)
# We count times appeared by the SOLO artist
total_num_hits <- count_num_hits(chart)
unique_num_hits <- unique(total_num_hits$num_hits)

feature_input <- selectInput(
    inputId = "num_hits",
    label = "Number of Hits", 
    choices = sort(unique_num_hits),
    selected = 5
)

feature_input2 <- selectInput(
    inputId = "num_hits2",
    label = "Number of Hits2", 
    choices = sort(unique_num_hits),
    selected = 5
)

tab_ui <-   fluidPage(
    titlePanel("Does Genre Affect Popularity?"),
    feature_input,
    tableOutput(outputId = "hits_table")
)

# Define UI for application that draws a histogram
ui <- fluidPage(
        tab_ui
)    



server <- function(input, output) {
    output$hits_table <- renderTable({
        hits_tab <- make_hits_table(input$num_hits, total_num_hits,
                                    chart_with_solos)
        hits_tab
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
