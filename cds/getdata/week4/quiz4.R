#####    Quiz 4    #####
########################

setwd("C:/Chris/cds/getdata/week4")

### Question 1

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "amcomsur.csv")
amcomsur <- read.csv("amcomsur.csv")
x <- strsplit(names(amcomsur), "wgtp")
x[123]


### Question 2

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "gdp.csv")
gdp <- read.csv("gdp.csv", skip=4, nrows=190)
tail(gdp)
head(gdp)
values <- as.numeric(gsub(",","",gdp$X.4))
mean(values)


### Question 3

grep("^United",gdp$X.3)


### Question 4

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "gdp2.csv")
gdp2 <- read.csv("gdp2.csv", skip=4, nrows=190)
gdp2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile = "edu.csv")
edu <- read.csv("edu.csv")
head(edu)
tail(edu)
names(edu)
grep("Fiscal year end: June",edu$Special.Notes)


### Question 5

install.packages("quantmod")
library("quantmod")

amzn = getSymbols("AMZN",auto.assign=FALSE)
head(amzn)
sampleTimes = index(amzn)
sampleTimes
table(year(sampleTimes))
table(weekdays(sampleTimes))
x <- sampleTimes[year(sampleTimes) == 2012]
table(weekdays(x))












