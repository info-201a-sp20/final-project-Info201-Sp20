# Helper functions to get the solo artist from our charts dataframe, used for
# making chart 2.

# Load in libraries
library(dplyr)
library(stringr)

# Takes in a string of artists, the character to stop at, and the respective
# offset for the character. Returns a new string that takes everything from the
# old string up to (and not including) the given character.
#
# If char is "&", offset is 2. If char is ",", offset is 1.
remove_str <- function(artist, char, offset) {
  sign_loc <- str_locate(artist, char)
  solo_artist <- str_sub(artist, 1, sign_loc[1] - offset)
  return(solo_artist)
}

# Takes a charts data frame. Returns a list of the top yearly artists WITHOUT
# the other featured artists
get_solo_artists <- function(df) {
  artists <- df$artist
  result <- list()
  for (i in seq(to = length(artists))) {
    if (str_detect(artists[i], "&") &&
        str_detect(artists[i], ",")) {
      no_ampersand <- remove_str(artists[i], "&", 2)
      solo_artist <- remove_str(no_ampersand, ",", 1)
      result[i] <- solo_artist
    } else if (str_detect(artists[i], "&")) {
      solo_artist <- remove_str(artists[i], "&", 2)
      result[i] <- solo_artist
    } else {
      result[i] <- artists[i]
    }
  }
  return(result)
}
