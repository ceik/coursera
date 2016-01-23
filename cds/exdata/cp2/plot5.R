#####    Course Project 1 - Plot 5    #####
###########################################

setwd("C:/Chris/cds/exdata/cp2")
library(ggplot2)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$type <- as.factor(nei$type)
nei$year <- as.factor(nei$year)

### Aggregate Data

balt <- nei[nei$fips == "24510",]

# Using type == "ON-ROAD" as suggested by course staff:
# https://class.coursera.org/exdata-013/forum/thread?thread_id=106#post-750
mv <- balt[balt$type =="ON-ROAD",]

sums_mv <- tapply(mv$Emissions, mv$year, sum)

# Plot 5

png(filename = "plot5.png", width = 480, height = 480)
barplot(sums_mv, main = "Emissions from Motor Vehicle Sources in Baltimore")
dev.off()