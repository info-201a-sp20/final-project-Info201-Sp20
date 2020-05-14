# Final Project Brainstorm

### Domain of Interest

##### Why are you interested in this field/domain?
We are interested in artist trends in the U.S. because we are curious to see
how artist preferences have changed over the years, what artists have stayed
relevant or popular, and what artists have fallen out of popularity. We feel
that music is an integral part of society, and music taste can often reflect
societal attitudes, especially those held by young people. Everyone in our
group is an avid music listener, and we are interested in gaining some insight
into how music popularity has evolved over time.

##### What other examples of data driven projects have you found related to this domain?
- https://www.youtube.com/watch?v=xczcnuW3u48
  - This project is a dynamic visualization of genre popularity
 from 1958 to 2015. Specifically, the data in this project tracks what
 percentage of Billboard Hot 100 Weekly Tracks are attributed to different
 genres over a span of about 55 years.
- http://thedataface.com/2016/09/culture/genre-lifecycles
  - This project details every song that has reached the Hot 100 spanning from
 1958 to 2016. The visualizations portray how long the particular song stayed
 on the Hot 100 list, who it’s artist was, and what genre it was attributed to.
 The project also shows how genre popularity has grown or shrunk over time, and
 provides breakdown data on genre prevalence each individual year.
- https://www.displayr.com/most-popular-music/
  - This project provides visualizations that compare and contrast genre and
 song popularity, as documented by Billboard 100 lists and Spotify. This
 project looks at the most listened to artists, songs, and genres documented by
 Spotify, and the songs listed on the Billboard Hot 100 and comments on the
 differences between these two datasets.


##### What data-driven questions do you hope to answer about this domain?
- Who was the most popular artist from 2010 to 2019?
  - To answer this question, we can find the artist with the highest number of
 songs in the Hot 100 list over this period. We can also look at which artist
 topped the Billboard charts the most times.
- What genres and artists fell in popularity?
  - To answer this, our team can find which genres had a decreasing amount of
 Hot 100 hits over the years. We can look into which genres have a decreased
 percentage of prevalence year to year based on the  Hot 100 list, for most
 given time periods.
- Which artist(s) appeared on the charts only once?
  - For this question, we’ll need to count how many times each artist appeared
 on the charts, then look at which ones appeared only once.
- How have genre trends changed over the past few decades?
  - To find how genere trends have changed over the past few decades, we can
 isolate the Hot 100 hits of the last few decades and look at which genres were
 most prevalent each year. We could then make a visualization that tracked
 swings in general popularity, potentially defined by the amount of songs on
 the Hot 100 billboard that are attributed to a particular genre.
- What was the most popular genre each year?
  - For this question, we can look at each year and see which artist had the
 most songs to hit the Hot 100 list. Alternatively, we could choose to define
 “most popular” as the artist with the number one song on the chart.
- What was the most popular artist each year?
  - This one might be a little tough. We’ll have to base it on which artists
 were popular each year, since we don’t have specific data tying genre to year.
 Once we find the top artist of each year, we can use the Spotify API to find
 out which genre those artists are associated with.

### Finding Data

##### Where did you download the data?
- Data 1: Top Charts between 2000-2020:
  - https://chart2000.com/about.htm
- Data  2: Spotify API (coupled with a package from GitHub)
  - https://developer.spotify.com/documentation/web-api/
  - https://github.com/charlie86/spotifyr
- Data 3: Analysis of Billboard Hot 100 Hits Through Time (1958-2015)
  - https://rstudio-pubs-static.s3.amazonaws.com/198801_49ebd6cd54f64d5cb60377820f4d6b89.html#data_sources

##### How was the data collected or generated?
- Data 1:
  - The U.S. top artist, album, and song data set was collected from
 www.billboard.com by Steve Hawtin. Steven Hawtin and his team have worked on a
 couple of projects consolidating musical data, and have been publishing their
 results since 2017.
- Data 2:
  -   Data is collected from each song’s metadata, which is then easily
 accessible through Spotify. This data was collected and posted to github by
 Charlie Thompson. Charlie Thompson is an independent data scientist and
 engineering consultant based in the greater seattle area.
- Data 3:
  - The data was collected from the billboard top 100 hits by Jennifer Brussow.
 Jennifer collected and read the data into R studio in order to manipulate the
 data to gain inferences on song popularity. This dataset contains the artist,
 song, year, and rank standing. Jennifer Brussow is a senior data scientist at
 Kognito who specializes in R programming.

##### How many observations are in your data?
- Data 1:
  - 2101 observations
- Data 2:
  - This will depend on how many different music genres the artist participates
 in.
- Data 3:
  - 299043 observations

##### How many features are in the data?
- Data 1:
  - 11 features
- Data 2:
  - 11 features
- Data 3:
  - 4 features

##### What questions can be answered using the data in this dataset?
- Data 1:
  - All of the questions we listed can be answered with the exception of the
 genre-related questions. This data set does not provide the genre associated
 with songs or artists.
- Data 2:
  - This API will help us answer questions relating to genre. The billboard
 chart data we found didn’t have any information on the music genres, so we
 will be using the API to gather this information.
- Data 3:
  - Similar to data set 1, all questions regarding popularity of certain artists
  or songs can be answered except for any genre related questions. The data in
	this set is older compared to data set 1.
