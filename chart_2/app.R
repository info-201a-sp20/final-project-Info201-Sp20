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
    tableOutput(outputId = "hits_table"),
    textOutput(outputId = "explain_sample")
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
    output$explain_sample <- renderText({
        if (as.integer(input$num_hits) <= 5) {
            paste0("There were a large quantity of artists with ", input$num_hits,
                   " hits, so shown in the table is a random selection of 
                   20 artists.")
        } else {
            paste0("These are all of the artists over the last 20 years who 
                   had ", input$num_hits, " hit songs.")
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
