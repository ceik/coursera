#####    Quiz Week 2    #####
#############################

### Question 1

# Using this tutorial on how to interact with the Github API via R:
# https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

library(httr)
library(httpuv)
# Get the OAuth settings for Github
oauth_endpoints("github")

# Create an App on Github, store and retrieve the ID & Key from local file
authfile <- read.csv("github_auth.csv", header = F)
keys <- as.character(unlist(authfile))
c_id <- keys[1]
c_secret <- keys[2]

# Create an OAuth application
myapp <- oauth_app("github", c_id, secret = c_secret)

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)

# Use API
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json <- jsonlite::fromJSON(toJSON(content(req)))
names(json)
ds_repo <- json[json$name == "datasharing", ]


### Question 2

library(sqldf)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "acs.csv")
acs <- read.csv("acs.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")


### Question 3

sqldf("select distinct AGEP from acs")


### Question 4

library(httr)

url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html <- GET(url)
content <- content(html, asText = T)
content[1]

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
lines = readLines(con)
close(con)
nchar(lines[10])
nchar(lines[20])
nchar(lines[30])
nchar(lines[100])


### Question 5

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
              destfile = "q5_data.for")

df <- read.fwf("q5_data.for", skip = 4, header = F, 
         widths = c(-1, 9, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4))
head(df)
sum(as.numeric(df$V4))