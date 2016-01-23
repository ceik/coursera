#####    Quiz 3    #####
########################

### Question 1

library(dplyr)
setwd("C:/Chris/cds/getdata/week3")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "amcomsur.csv")
acs <- read.csv("amcomsur.csv")


a <- acs[, "AGS"]
b <- acs[, "ACR"]
at <- a == 6
bt <- b == 3
ct <- (a == 6 & b == 3)
which(ct == TRUE)


### Question 2

install.packages("jpeg")
library(jpeg)

setwd("C:/Chris/cds/getdata/week3")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              destfile = "jeff.jpeg", mode = "wb")

pic <- readJPEG("jeff.jpeg", native = T)
qants <- quantile(pic, probs = c(0.3, 0.8))
qants

### Question 3

library(plyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile = "edu.csv")
gdp <- read.csv("gdp.csv", skip = 3, stringsAsFactors=FALSE) 
#                colClasses = c(character, numeric, character, character, numeric,
#                              character, character, character, character, character))
edu <- read.csv("edu.csv", stringsAsFactors=F)


gdp2 <- gdp[2:191,]
gdp2

gdp2$US.dollars. <- gsub(",","",gdp2$US.dollars.)
gdp2$US.dollars. <- gsub(" ","",gdp2$US.dollars.)
gdp2$US.dollars. <- as.numeric(as.character(gdp2$US.dollars.))


arrange(gdp2, US.dollars.)

intersect(gdp2$X, edu$CountryCode)


### Question 4

gdp2$Ranking <- as.numeric(as.character(gdp2$Ranking))

names(edu)
names(gdp2)

merged <- merge(gdp2, edu, by.x = "X", by.y = "CountryCode", all = F)
merged$Income.Group
oecd <- merged[merged$Income.Group=="High income: OECD",]
mean(oecd$Ranking)

non_oecd <- merged[merged$Income.Group=="High income: nonOECD",]
mean(non_oecd$Ranking)


### Question 5

merged$quants <- cut(merged$US.dollars., 
                     breaks = quantile(merged$US.dollars., 
                                       probs = c(0.2,0.4,0.6,0.8,1)))
quant <- quantile(merged$US.dollars.)
merged$US.dollars.


merged$quant <- cut(merged$US.dollars., 
                    breaks = quantile(merged$US.dollars.,probs = seq(0, 1, by = 0.20)),
                    labels=c("0-20","20-40","40-60","60-80","80-100"),
                    include.lowest=TRUE)
table(merged$quant, merged$Income.Group)
a <- merged[merged$quant == "80-100",]
mean(a$US.dollars.)

quantile(merged$US.dollars.,probs = c(0.2,0.4,0.6,0.8,1))
?quantile























