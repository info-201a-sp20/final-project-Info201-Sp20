library(shiny)

# This file contains the function for making the table
source("Shiny_app/build_chart2.r", local = T)

# I had made this file to contain the UI I made for the table. But when
# sourcing this file, it wasn't recognizing line 15 below, so that object
# didn't exist. 
#source("Shiny_app/chart_2_ui.R", local = T)

# Because of this, I think we might have to paste all of UI work into this
# file. Same with the server file too. I saw a lot of groups online do this
# as well.

chart <- read.csv("Data/charts_w_genres.csv", stringsAsFactors = FALSE)
# Building the dataframe for the table -----
chart_with_solos <- add_solo_artists(chart)
# We count times appeared by the SOLO artist
total_num_hits <- count_num_hits(chart)
unique_num_hits <- unique(total_num_hits$num_hits)

# Feautre input for the table -----
feature_input_table <- selectInput(
  inputId = "num_hits",
  label = "Number of Hits", 
  choices = sort(unique_num_hits),
  selected = 5
)


# ui for the table -----
table_ui <- fluidPage(
  feature_input_table,
  tableOutput(outputId = "hits_table")
  )

ui <- shinyUI(
  navbarPage(title = "Project",
             tabPanel("Introduction",
               mainPanel(
                  titlePanel("Info 201 Final Project"),
                 
                 h2("Introduction Paragraph"),
                 p("Music is an integral part of society. Culture and music 
                   taste can reflect societal attitudes, especially those held 
                   by young people. This project shows how music genres have 
                   risen and fallen in popularity over time. We are interested 
                   in these trends because we want to see what makes a song or 
                   artist \"popular\" and what does not. Additionally, we wanted
                   to know if there is one genre that dominates the music 
                   industry, or if there is a wide variety of popular genres. 
                   This could be information to aspiring song-writers who want 
                   to make it big one day, or information for anyone interested 
                   in music trends. Everyone in our project group is an avid 
                   music listener and listens to a wide variety of genres. Are 
                   any of the genres we personally listen to represented in 
                   popular music? That is what we aimed to find out. "),
               p("We looked at the Billboard Hot 100 list from the year 2000 
                   to 2000, which is a list of the most popular songs in the US.
                   The Billboard Chart lists 100 artists and songs each year, 
                   ranking them by several factors, including number of times 
                   their song was streamed, and how much money the song made. 
                   This dataset was compiled by Steven Hawtin. We used version 
                   0.3.0058. The dataset can be found ",
                   a(href="https://chart2000.com/about.htm"), "here. Under the "
                   , strong("Results"), " heading, click the csv file labeled ",
                   em("Songs of the year"), " to see the full dataset"),
                p("Here's a section of the data frame that we used in our 
                   analysis."),
                tableOutput("chart_example"),
                p("Year : What year the song/artist showed up on the chart"),
                p("Artist: The artist of the song"),
                p("Postion: The song ranking on the chart (1-100)"),
                p("Song: The song title"),
                p("Indicative Revenue: How much money the song earned in that 
                  year"),
                p("Genre: The genre of the artist"),
                 
                 img("We hope you like our project", 
                     src = "https://media1.tenor.com/images/734f279d1a68fa0c8f07855f9723e6ca/tenor.gif?itemid=15878489")
                 )
               ),
             tabPanel("Table",
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
                      ))
             
      )
)