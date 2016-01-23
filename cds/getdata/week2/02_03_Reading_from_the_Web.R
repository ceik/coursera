#####    Reading from the Web    #####
######################################

### Webscraping

# Webscraping means programatically extracting data from the html code of 
# websites. This is often against the terms of service for the website and
# reading many pages too quickly can get your IP address blocked.
#
# Example page to be used: 
# http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en


### Ways to Scrape Websites

# Using readLines() will result in an unformatted string of html code. Make
# sure to close the connection.
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

# Using the XML library.
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//a[@class='gsc_a_ac']", xmlValue)

# Using the httr package
library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText=T)
xpathSApply(parsedHtml, "//title", xmlValue)

# Using the httr package for password protected sites
library(httr)
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user", "passwd"))
names(pg2)
content3 = content(pg2, as="text")

# Use a handle when dealing with website connections. Cookies will stay with the
# handle and you won't have to authenticate all the time.
google = handle("http://google.com")
pg5 = GET(handle=google, path = "/")
pg6 = GET(handle=google, path = "search")


# R Bloggers has a number of examples on web scraping. Also the httr help file
# on CRAN has useful examples.














