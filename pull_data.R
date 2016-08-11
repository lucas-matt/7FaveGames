#install.packages("twitteR")

library(twitteR)
library(plyr)

# expected R file called credentials.R with :
# consumer_key = "..."
# consumer_secret = "..."
# access_token = "..."
# access_secret = "..."
source("credentials.R")
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

batch <- 500
pull <- TRUE
tweets <- searchTwitter("#7FaveGames", n=batch, retryOnRateLimit=batch)
parsed <- do.call("rbind.fill", lapply(tweets, as.data.frame))
write.table(parsed, file="7favegames.csv", sep=",", append=TRUE, col.names=TRUE)

while (pull) {
  id <- parsed$id[batch]
  print(c("Getting batch with id ", id))
  tweets <- searchTwitter("#7FaveGames", n=batch+1, retryOnRateLimit=batch, maxID=id)
  parsed <- do.call("rbind.fill", lapply(tweets, as.data.frame))
  parsed <- parsed[-(1:1),]
  write.table(parsed, file="7favegames.csv", sep=",", append=TRUE, col.names=FALSE)
  pull <- (nrow(parsed) > 1) || (!is.na(id)) 
  Sys.sleep(10)
}


