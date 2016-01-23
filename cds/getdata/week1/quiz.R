#####    Quiz 1    #####
########################

### Question 1
install.packages("data.table")
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "./amcomsur.csv")
data2 <- fread("amcomsur.csv")
head(data2)
data_idaho <- data2[data2$VAL == 24]


### Question 3
library(xlsx)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
             destfile = "./ngap.xlsx", mode = "wb")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
dat <- read.xlsx("ngap.xlsx", sheetIndex = "NGAP Sample Data", header = T, colIndex = 7:15, 
                 rowIndex = 18:23)
sum(dat$Zip*dat$Ext,na.rm=T)


### Question 4
library(XML)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
              destfile = "./rest.xml")
rest <- xmlTreeParse("rest.xml", useInternal = T)
abc <- xmlRoot(rest)
xmlName(root)
names(root[[1]][[1]])
root[[1]][[1]]
zips <- xmlSApply(root[[1]][[1]][[2]], xmlValue)
zips2 <- xmlSApply(root[[1]][[1]], function(x) xmlSApply(x, xmlValue))



nodes <- getNodeSet(root, "//zipcode")
test = xmlSApply(nodes, function(x) xmlSApply(x, xmlValue))

data <- table(test)


### Question 5
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "./amcomsur2.csv")
DT <- fread("amcomsur2.csv")

mean(DT$pwgtp15,by=DT$SEX)
system.time(mean(DT$pwgtp15,by=DT$SEX))

#mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

#tapply(DT$pwgtp15,DT$SEX,mean)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

DT[,mean(pwgtp15),by=SEX]
system.time(DT[,mean(pwgtp15),by=SEX])

#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]

#sapply(split(DT$pwgtp15,DT$SEX),mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))



