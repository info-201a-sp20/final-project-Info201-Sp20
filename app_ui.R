library(shiny)
library(ggplot2)
library(plotly)
library("shinythemes")
# This file contains the function for making the table
source("Shiny_app/build_chart2.r")


chart <- read.csv("data/charts_w_genres.csv", stringsAsFactors = FALSE)
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
genredf_stripped <- subset(chart, select = -c(year, position, song,
                                                indicativerevenue, X)) %>%
  group_by(genre) %>%
  summarize(num_artist = n())

# UI for the main page ----
ui <- shinyUI(
  fluidPage(
    includeCSS("www/style.css"),
    theme = shinytheme("cosmo"),
  navbarPage(title = "Final Project",
             tabPanel("Introduction",
               mainPanel(
                 align = "center",
                 width = 12,
                 # Image
                 htmlOutput("splash"),
                 column(4, offset= 4, align = "justify",
                 h3("Introduction"),
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
                 p(em("The main questions we sought to answer were:")),
                 tags$ul(
                   tags$li("How does the genre of an artist affect their 
                           popularity?"),
                   tags$li("Is the amount of artists present in the Billboard 
                           100 Chart
                           impacted by genre?"),
                   tags$li("How has genre popularity changed over the past 20 
                           years?")
                   
                 ),
               p("We looked at the Billboard Hot 100 list from the year 2000 
                   to 2000, which is a list of the most popular songs in the US.
                   The Billboard Chart lists 100 artists and songs each year, 
                   ranking them by several factors, including number of times 
                   their song was streamed, and how much money the song made. 
                   This dataset was compiled by Steven Hawtin. We used version 
                   0.3.0058. The dataset can be found ",
                   a(href="https://chart2000.com/about.htm", "here."), "Under 
                 the ", strong("Results"), " heading, click the csv file 
                 labeled ", em("Songs of the year"), " to see the full 
                 dataset"),
                 p("Here's a section of the data frame that we used in our 
                   analysis."),
               tableOutput("chart_example")))),
             
             # tabPanel("Genre Trends Over the Years"
             #          # Molly's chart UI would get pasted here
             #          ),
             
             tabPanel("Artist Popularity by Genre",
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
                            number of times they appeared on the charts 
                            (deemed as ", em("Number of Hits"), ").", br(), 
                            br(), "You can select a number of hits to display 
                            in the table using the drop down menu. The table 
                            will then display artists and their respective 
                            genre who had the total number of hits selected.")),
                        column(4,
                               br(),
                               tags$div(id="text_output",
                                        style=p_tag_style,
                                        textOutput(
                                          outputId = "explain_sample")),
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
                            "Does this mean that pop songs tend to make it on 
                            the charts more often than any of the other genres? 
                            Well, according to this data, yes. Pop is the most 
                            popular genre to appear on the Billboard Charts. 
                            It wouldn't be a surprise to most though, as many 
                            of the artists with a high number of hits (Rihanna, 
                            Maroon 5, etc) are rather well known artists. These 
                            artists are relevant in popular media, which could 
                            play into their general popularity.",
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
                            stuck in your head, you go to listen to it on 
                            Spotify because it's stuck in your head, and the 
                            song earns more popularity. It's a simple cycle 
                            that has worked for many of the artists that appear 
                            on the charts."))),
                      fluidPage(
                        h3("Frequency of Genres"),
                        fluidRow(
                          column(6, plotlyOutput("freq_chart_5",
                                                 width = "500px", 
                                                 height = "400px")),
                          column(4, plotlyOutput("freq_chart_10",
                                                 width = "500px",
                                                 height = "400px"))
                        ),
                        p(style=p_tag_style,
                          "If we take a look at the frequency each genre
                          appears in one of the tables, it becomes further 
                          obvious that there is a clear winner. Since there
                          were a large number of artists with 5 hits, the 
                          chart only shows a random selection of 15 artists,
                          but the trends still stand. We can see that for 
                          artists with 5 hits, there is a good variety of genres
                          that appear, but pop is still the most frequent one.
                          When taking a look at artists with 10 hits, we find 
                          that there are 7 total, and 6 of them are pop artists.
                          These plots show that the more hits an artist has, the
                          more likely they are to be a pop artist.")
                      )),
 
          tabPanel("Genre Saturation in the Charts",
            titlePanel("Which Genres Do Top Artists Belong To?"),
              fluidRow(
                column(4,
               selectInput(
                 "genre", label = "Choose genres to display:",
                           choices = genredf_stripped$genre, multiple = T,
                           selected = c("pop", "metal", "rap", "soul")),
               h3("Visualization Justification"),
               p(style = p_tag_style,
                 strong("This chart attempts to show the
            differences in genre saturation. Genre saturation is defined by the
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
            listed.")),
          column(4,(plotlyOutput("pieplot"))),
          column(4,
            h3("Analysis"),
            p(style = p_tag_style,
              "Judging from the data, the easiest conclusion that can be drawn
              is that pop dominates the pie chart. Adding more genres to the
              pie chart makes it clear that the number of artists who 
              are categorized as pop remain the most prominant. At least over 
              the last 20 years, the saturation of pop music with respect to 
              other genres is almost always over 50%.", br(), br(), 
              
              "Another thing to note is the relevance of hip hop music in the 
              chart. When comparing all of the genres against each other, hip
              hop saturated 11.7% of the Billboard Chart, making it the second
              most popular genre. From this, we can make the conclusion that
              genre ", strong("does"), " have an impact on an artist's
              popularity. Artists of the genres pop or hip hop appear more 
              frequently on the Billboard Charts. Because of this, it's fair to
              assume that lesser known artists in these genres have a chance at
              becoming popular, since pop and hip hop are the two most popular
              genres."))))
           ,
       tabPanel("Summary Findings",
                titlePanel("Summary Findings"),
                h3("Saturation of Artist Per Genre"),
                p(style=p_tag_style,
                "Upon observation, there are about seven prominent genres that 
                 a larger population of artists are in. These genres include 
                 pop, hip hop, rap, rock, country, metal and soul. As we can 
                 observe from the analysis done in the genre saturation page. 
                 The music industry is saturated with pop artists. Other genres 
                 pail in comparison to the juggernaut, pop music. From this we 
                 can hypothesize that the market for pop songs is in high demand 
                 and could be highly competitive. On the contrary, something 
                 like urban contemporary is probably not as competitive. As a 
                 new artist, the chance of being the top of a lower saturated 
                 genre is high but the question turns to the success of a genre.
                 With lower demands the chance of overall success will be 
                 low."), 
                h3("The Success of an Artist According to Genre"),
                p(style = p_tag_style,
                 "When considering the success of an artist, there are many ways
                  of measuring success. For the sake of clarity, we will be 
                  measuring based on the number of top hits. Like we previously 
                  stated, the demand for pop music is high. Therefore we see a 
                  large pop music presence in the music industry. In the last 20
                  years pop artists have been in the top charts. Artists with 
                  1-39 top hits in the last 20 years, at least one of them falls
                  in the genre of pop. We can infer that genre plays a role in 
                  the success of artists by the obvious presence of pop in the 
                  top charts. Although that may be the case, not all artists 
                  under the pop genre achieve success. For example, Rihanna is 
                  the only artist to achieve 39 top hit songs. The ability to 
                  achieve this suggests that Rihanna has a large and faithful 
                  audience."), 
                h3("Stability of genres"),
                p(style = p_tag_style,
                "A faithful following, higher demand and a larger audience 
                 could be a good explanation to the stable success of the pop 
                 genre. Through the last 20 years pop has had the leading top 
                 hits for all but one year.  In 2004 Hip Hop surpassed Pop in 
                 the number of hits but soon fell short of Pop the following 
                 years. Although pop music dominate the charts that doesn't mean
                 that other genres are sustainable but the top artists of pop 
                 music find the most success."),
                h3("Conclusion "), 
                p(style = p_tag_style,
                "With our analysis we can come to a conclusion that pop has the 
                most success compared to other genres. With a larger demand and
                a constant presence in the top charts, we can  easily observe 
                the popularity of this genre. While this may excite new artists 
                looking to find success in the music industry, one must keep in 
                mind the saturation of artists in the music industry. Although 
                saturation is not a definitive measurement of competitiveness, 
                it still sheds some light on the matter."), 
                h3("Question to further Consider"), 
                
                p(style = p_tag_style,
                "Because our analysis gives some insight on the viability of 
                 the music market but doesn't take into account the one-hit 
                 wonders of the music industry nor the sustainability of each 
                 genre. We may consider to look into the sustainability of each 
                 genre, the population of listeners per genre, and the popular 
                 means of distribution."))
  ) #end navbarPage

  ))

