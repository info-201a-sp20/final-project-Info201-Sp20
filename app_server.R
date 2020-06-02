server <- function(input, output) {
  # we can insert the innards of everyone else's server function here
  # I don't think we can source separate files, I think it all needs to be
  # in one spot
  output$chart_example <- renderTable({
    get_example <- function(chart) {
      chart_tab <- chart %>% 
        select(-X) %>% 
        head(5)
      names(chart_tab)[1] <- "Year"
      names(chart_tab)[2] <- "Artist"
      names(chart_tab)[3] <- "Position"
      names(chart_tab)[4] <- "Song"
      names(chart_tab)[5] <- "Indicative Revenue"
      names(chart_tab)[6] <- "Genre"
      return(chart_tab)
    }
    chart_tab <- get_example(chart)
    chart_tab
  })
  
  output$hits_table <- renderTable({
    hits_tab <- make_hits_table(input$num_hits, total_num_hits,
                                chart_with_solos)
    hits_tab
  })
  output$explain_sample <- renderText({
    if (as.integer(input$num_hits) <= 5) {
      paste0("There were a large quantity of artists with ", input$num_hits,
             " hits, so shown in the table is a random selection of 
                   15 artists.")
    } else {
      paste0("These are all of the artists over the last 20 years who 
                   had ", input$num_hits, " hit songs.")
    }
  })
}
