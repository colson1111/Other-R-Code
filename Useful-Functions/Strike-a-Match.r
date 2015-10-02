#  This function calculates a score between 0 and 1 based on the similarity between two strings.
#  http://www.catalysoft.com/articles/StrikeAMatch.html

strikematch <- function(str1, str2){
  # find out how many adjacent character pairs are contained in both strings
  str1 <- toupper(str1)
  str2 <- toupper(str2)

  vec1 <- letterPairs(str1)
  vec2 <- letterPairs(str2)

  intersection <- 0
  union <- length(vec1) + length(vec2)

  i <- 1

  while (i <= length(vec1)){
    pair1 <- vec1[i]
    j <- 1

    while (j <= length(vec2)){
      pair2 <- vec2[j]

      if(pair1 == pair2){
        intersection <- intersection + 1
        vec2 <- vec2[! vec2 %in% pair2]
        j <- j - 1
      }

      j <- j + 1

    }

    i <- i + 1

  }

  score <- (2 * intersection) / union
  return(score)

}

letterPairs <- function(str){
  numpairs <- nchar(str) - 1
  i <- 1
  pairs <- vector(mode = "character", length = numpairs)
  while (i < numpairs + 1){
    pairs[i] <- substring(str, i, i + 1)
    i <- i + 1
  }
  pairs <- gsub(" ", "", pairs, fixed = TRUE)
  pairs <- subset(pairs, nchar(pairs) == 2)
  return(pairs)
}
