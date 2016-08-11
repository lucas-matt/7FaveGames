#install.packages("twitteR")

library(twitteR)

# expected R file called credentials.R with :
# consumer_key = "..."
# consumer_secret = "..."
# access_token = "..."
# access_secret = "..."
source("credentials.R")
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


all <- searchTwitter("#7FaveGames", n=6)
res <- searchTwitter("#7FaveGames", n=3)
id <- res[[3]]$id
res2 <- searchTwitter("#7FaveGames", n=3, maxID=id)
all
res
res2

