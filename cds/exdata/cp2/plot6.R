#####    Course Project 1 - Plot 6    #####
###########################################

setwd("C:/Chris/cds/exdata/cp2")
library(ggplot2)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$type <- as.factor(nei$type)
nei$year <- as.factor(nei$year)


### Aggregate Data

balt <- nei[nei$fips == "24510",]
la <- nei[nei$fips == "06037",]

# Using type == "ON-ROAD" as suggested by course staff:
# https://class.coursera.org/exdata-013/forum/thread?thread_id=106#post-750
mv_balt <- balt[balt$type =="ON-ROAD",]
mv_la <- la[la$type =="ON-ROAD",]

sums_mv_balt <- tapply(mv_balt$Emissions, mv_balt$year, sum)
sums_mv_la <- tapply(mv_la$Emissions, mv_la$year, sum)


# Plot 6

png(filename = "plot6.png", width = 480, height = 480)
par(mfrow = c(1,2))
barplot(sums_mv_balt, ylab = "Emissions from Motor Vehicle Sources in Baltimore")
barplot(sums_mv_la, ylab = "Emissions from Motor Vehicle Sources in Los Angeles County")
dev.off()