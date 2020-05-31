library(shiny)

source("build_chart2.r")

# change to capital D later
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

table_ui <-   fluidPage(
    feature_input,
    tableOutput(outputId = "hits_table")
)

ui <- fluidPage(
    titlePanel("Does Genre Affect Popularity?"),
    sidebarLayout(
        sidebarPanel(
            textOutput(outputId = "explain_sample"),
            h2("Analysis"),
            p("We discovered that artists with more hits tend to fall within
              the same genre category. A lot of the artists with 10 or more
              hits all fall under pop as their genre."),
            br(),
            p("Does this mean that pop songs tend to make it on the charts more
              often than any of the other genres? Well, according to this data,
              yes. A lot of popular songs in the US are pop songs. This isn't
              to say that other genres are bad though."),
            br(),
            p("Pop songs tend to be written in a catchy, easy to remember kind
               of style. They have repeating riffs and melodies that are
               designed to get stuck in your head.",
              a(href = "https://cbsn.ws/2XR0D2K", "This CBS News article"), "talks
              about the concept of \"earworms\" and through a study, found that,
              ", em("\"songs most likely to get stuck in people's heads shared 
                    common \"melodic contours,\" mainly found in Western pop 
                     music.\""))
        
        ),
        mainPanel(table_ui)
    )
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
