server <- function(input, output) {
  #Visual resourses
  src = "https://iili.io/JOLtql.png"
  output$splash <- renderText({c('<img src="',src,'">')})


  # Charts
  
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
  
  output$freq_chart_5 <- renderPlotly({
    hits_table_5 <- make_hits_table(5, total_num_hits, chart_with_solos)
    bar_chart_5 <- plot_genre_frequency(hits_table_5, 5)
    bar_chart_5
  })
  
  output$freq_chart_10 <- renderPlotly({
    hits_table_10 <- make_hits_table(10, total_num_hits, chart_with_solos)
    bar_chart_10 <- plot_genre_frequency(hits_table_10, 10)
    bar_chart_10
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
  # Pie Plot Page
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
                         "<b>Genre: </b>%{label}",
                         "<br><b>Percent: </b>%{percent}",
                         "<br><b># of Artists:</b>","%{value}",
                         "<extra></extra>"))  %>%
      layout(title = "Amount of Artists in Each Genre",
             xaxis = list(showgrid = FALSE, zeroline = FALSE,
                          showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE,
                          showticklabels = FALSE))
  })
}

