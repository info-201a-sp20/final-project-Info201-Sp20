#library 
library("shiny")

# Summary

summary <- fluidPage(
  titlePanel("Summary Analysis "),
  
  #header: saturation 
  h2("Saturation of Artist per Genre"),
  
  #first take away 
  p("Upon observation, there are about seven prominent genres that a larger population 
  of artists are in. These genres include pop, hip hop, rap, rock, country, metal and soul. 
  As we can observe from the analysis done in the genre saturation page. The music industry 
  is saturated with pop artists. Other genres pail in comparison to the juggernaut, pop music.
  From this we can hypothesize that the market for pop songs is in high demand and possibly be 
  highly competitive.On the contrary something like urban contemporary is probably not as competitive. 
  As a new artist the chance of being the top of a lower saturated genre is high but the question turns 
  to the success of a genre. With lower demands the chance of overall success will be low."), 
  
  #header: success 
  h2("The Success of Artist according to genre"),
  
  #second take away 
  p("When considering the success of an artist, there are many ways of measuring success. 
    For the sake of clarity we will be measuring based on the number of top hits. Like we previously stated, 
    the demand for pop music is high. Therefore we see a large pop music presence in the music industry. 
    In the last 20 years pop artists have been in the top charts. Artists with 1 to 39 top hits in the last 20 years, 
    at least one of them falls in the genre of pop. We can infer that genre plays a role in the success of artists by 
    the obvious presence of pop in the top charts. Although that may be the case, not all artists under the pop genre 
    achieve success. For example, only Rhinna is the only artist to achieve 39 top hit songs. The ability to achieve 
    this suggests that Rhianna has a large and faithful audience."), 
  
  #header: stability 
  h2("Stability of genres"),
  
  #third take away
  p("A faithful following, higher demand and a larger audience could be a good explanation to the stable success of the pop genre.
  Through the last 20 years pop has had the leading top hits for all but one year.  In 2004 Hip Hop surpassed Pop in the number of
  hits but soon fell short of Pop the following years. Although pop music dominate the charts that doesn't mean that other genres 
  are sustainable but the top artists of pop music find the most success."),
  
  #header: Conclusion
  h2("Conclusion "), 
  
  p("With our analysis we can come to a conclusion that pop has the most success compared to other genres. With a larger demand and
  a constant presence in the top charts, we can  easily observe the popularity of this genre. While this may excite new artists looking
  to find success in the music industry, one must keep in mind the saturation of artists in the music industry. Although saturation is 
  not a definitive measurement of competitiveness, it still sheds some light on the matter."), 
  
  #header: Question to further Consider 
  h2("Question to further Consider"), 
  
  p("Because our analysis gives some insight on the viability of the music market but doesn't take into account the one hit wonders 
    of the music industry nor the sustainability of each genre. We may consider to look into the sustainability of each genre, the 
    population of listeners per genre, and the popular means of distribution.")
  )

#test 
summary 
