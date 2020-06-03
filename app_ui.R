library(shiny)
library("shinythemes")
# This file contains the function for making the table
source("Shiny_app/build_chart2.r")

# I had made this file to contain the UI I made for the table. But when
# sourcing this file, it wasn't recognizing line 23 below, so that object
# didn't exist. 
#source("Shiny_app/chart_2_ui.R")

# Because of this, I think we might have to paste all of UI work into this
# file. Same with the server file too. I saw a lot of groups online do this
# as well.

# Unless someone can figure out how we source other UI files into this one,
# that'd be great!!!

chart <- read.csv("Data/charts_w_genres.csv", stringsAsFactors = FALSE)
# Building the dataframe for the table -----
chart_with_solos <- add_solo_artists(chart)
# We count times appeared by the SOLO artist
total_num_hits <- count_num_hits(chart)
unique_num_hits <- unique(total_num_hits$num_hits)

# Feautre input for the table -----
feature_input_table <- selectInput(
  inputId = "num_hits",
  label = "Select a number of hits", 
  choices = sort(unique_num_hits),
  selected = 5
)

p_tag_style <- 
  "border-radius: 10px;
   padding: 10px 20px 10px 20px;
   background-color: #f5f5f5;
   "
# Data frame input for Pie chart ------
genredf <- read.csv("Data/charts_w_genres.csv", stringsAsFactors = FALSE)
genredf_stripped <- subset(genredf, select = -c(year, position, song,
                                                indicativerevenue, X)) %>%
  group_by(genre) %>%
  summarize(num_artist = n())

# UI for the main page
ui <- shinyUI(
  fluidPage(theme = shinytheme("readable"),
  navbarPage(title = "Final Project",
             tabPanel("Introduction",
               mainPanel(
                  titlePanel("Info 201 Final Project"),
                 
                 h3("Introduction Paragraph"),
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
                   popular music? That is what we aimed to find out."),
               p("We looked at the Billboard Hot 100 list from the year 2000 
                   to 2000, which is a list of the most popular songs in the US.
                   The Billboard Chart lists 100 artists and songs each year, 
                   ranking them by several factors, including number of times 
                   their song was streamed, and how much money the song made. 
                   This dataset was compiled by Steven Hawtin. We used version 
                   0.3.0058. The dataset can be found ",
                   a(href="https://chart2000.com/about.htm", "here."), "Under the "
                   , strong("Results"), " heading, click the csv file labeled ",
                   em("Songs of the year"), " to see the full dataset"),
                p("Here's a section of the data frame that we used in our 
                   analysis."),
               tableOutput("chart_example"),
               p(strong("We hope you like our project!")),
                 img(src = "https://media.giphy.com/media/Vz1cEfM0VFpII/giphy.gif")
                 )
               ),
             # Molly's chart UI would get pasted here, 
             
             tabPanel("Table",
                      titlePanel("Does Genre Affect Popularity?"),
                      fluidRow(
                        column(4,
                              feature_input_table,
                          h3("Visualization Justification"),
                          p(style=p_tag_style,
                          "The purpose of this table is to explore the 
                            relationship between genre and artist
                            popularity. We wanted to see how genre affects the 
                            number of hits an artist has. This table shows an 
                            artist, their respective genre, and the
                            number of times they appeared on the charts (deemed as ", 
                            em("Number of Hits"), ").", br(), br(),
                           "You can select a number of hits to display in the 
                            table using the drop down menu. The table will then 
                            display artists and their respective genre who had
                            the total number of hits selected.")),
                        column(4,
                               br(),
                               tags$div(id="text_output",
                                        style=p_tag_style,
                                        textOutput(outputId = "explain_sample")),
                               br(),
                               tableOutput(outputId = "hits_table")),
                        column(4,
                          h3("Analysis"),
                          p(style=p_tag_style,
                          "We discovered that artists with more hits tend to 
                            fall within the same genre category. A lot of the 
                            artists with 10 or more hits all fall under pop as 
                            their genre. For songs that had upwards of 12 hits, 
                            the pop genre nearly completely dominated the 
                            charts, with some apperances of hiphop and rock.",
                          br(),
                          "Does this mean that pop songs tend to make it on the 
                          charts more often than any of the other genres? Well, 
                          according to this data, yes. Pop is the most popular
                          genre to appear on the Billboard Charts. It wouldn't
                          be a surprise to most though, as many of the artists 
                          with a high number of hits (Rihanna, Maroon 5, etc) 
                          are rather well known artists. These artists are 
                          relevant in popular media, which could play into their
                          general popularity.
                          ",
                          br(), br(),
                          "There is another explanation as to why pop songs
                           are generally seen on the charts. Pop songs tend to 
                           be written in a catchy, easy to remember kind
                           of style. They have repeating riffs and melodies 
                           that are designed to get stuck in your head.",
                            a(href = "https://cbsn.ws/2XR0D2K", "This CBS News 
                            article"), "talks about the concept of \"earworms\" 
                            and through a study, found that, ", 
                            em("\"songs most likely to get stuck in people's 
                            heads shared common \"melodic contours,\" mainly 
                            found in Western pop music.\""), "The music gets
                          stuck in your head, you go to listen to it on Spotify
                          because it's stuck in your head, and the song earns
                          more popularity. It's a simple cycle that has worked
                          for many of the artists that appear on the charts.")
                        )
                      ))),
  # Pie
  tabPanel("Pie Chart",
           titlePanel("Which Genres Do Top Artists Belong To?"),
           fluidRow(
             column(4,
               selectInput("genre", label = "Choose genres to display:",
                           choices = genredf_stripped$genre, multiple = T),
               h3(align = "center", "Visualization Justification"),
               p(style = p_tag_style,
                 strong("This chart attempts to show the
            differences in genre density. Genre density is defined by the
            amount of top artists from 2000 - 2020 in each genre."), br(), br(),
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
             column(4,(plotlyOutput("pieplot")))
             )
           )
  )
             # Chris's UI would get pasted here.
             # The order doesn't really matter though (it just rearranges the tabs
             # at the top of the page), but I added these comments just so you
             # can visualize what the final would look like.
  )
