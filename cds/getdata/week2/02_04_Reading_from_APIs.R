#####    Reading Data from APIs    #####
########################################

### APIs

# APIs allow you to programmatically pull data from an application. It is
# usually required to create an account with the API to get access. For this
# lecture we'll use the Twitter API, for which an account can be created here:
# http://dev.twitter.com/apps


### Accessing the Twitter API

# Store Keys and Access Token locally so it doesn't show on Github.
library(httr)
library(jsonlite)
authfile <- read.csv("twitter_auth.csv", header = F)
keys <- as.character(unlist(authfile))
c_key <- keys[1]
c_secret <- keys[2]
a_token <- keys[3]
a_token_secret <- keys[4]


# Set up the connection to the app
myapp = oauth_app("twitter", key = c_key, secret = c_secret)
sig = sign_oauth1.0(myapp, token = a_token, token_secret = a_token_secret)
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))


# When using an API, read the documentation! E.g. the Twitter documentation:
# https://dev.twitter.com/overview/documentation. This includes info on the
# REST API used above.

# httr allows GET, POST, PUT, and DELETE requests if authorized. Most modern
# APIs use something like oauth for authorization. httr works well with 
# Facebook, Google, Twitter, Github, etc. On the httr Github account you can
# find demos for using httr on different sites.

















