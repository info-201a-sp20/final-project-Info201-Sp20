
fluidPage(
   titlePanel("Info 201 Final Project"),
   
   h2("Introduction Paragraph"),
   p(
      "In this project, we will explore how music genres, artists, and songs have risen
   and fallen in popularity over time.  We are interested in artist trends in the
   U.S. because we want to see how artist preferences have changed over the
   years, what artists have stayed relevant or popular, and what artists have
   fallen out of popularity. Music is an integral part of society, and
   culture and music taste can reflect societal attitudes, especially those
   held by young people. Everyone in our group is an avid music listener, and we
   are interested in gaining some insight into how music popularity has evolved
   over time. In our analysis of this subject we worked with 2 seperate datasets.
   The first dataset we explored was a compiled information on songs and artists
   that gained enough popularity to be listed on the Billboard Hot 100 list from
   2000 to 2020, which is a list of the most listened to songs in the U.S.A. We
   used this dataset to find summary information concerning which songs were most
   listened to and which artists made the most revenue, among other things. We
   utilized the Spotify API to extract supplementary data for the songs in our
   first dataset. We were able to use this data to search for popular artists that
   showed up in the analysis of previous dataset, and discover what genre the song
   or artist writes their music in. We also used this data in later charts to help
   visualize the analysis we did, which you will see later in our report."),
   
   p(a(href="https://chart2000.com/about.htm", "Here is a link to our data! 
  Scroll down to results, and click", em("Songs of the year"), "to see the full list!")),
     
     img("We hope you like our project", 
         src = "https://media1.tenor.com/images/734f279d1a68fa0c8f07855f9723e6ca/tenor.gif?itemid=15878489")
     
   )