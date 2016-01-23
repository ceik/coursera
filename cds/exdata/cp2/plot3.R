#####    Course Project 1 - Plot 3    #####
###########################################

setwd("C:/Chris/cds/exdata/cp2")
library(ggplot2)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$type <- as.factor(nei$type)
nei$year <- as.factor(nei$year)


### Aggregate Data

balt <- nei[nei$fips == "24510", ]


# Plot 3

png(filename = "plot3.png", width = 480, height = 480)
g <- ggplot(balt, aes(year, Emissions))
g <- g + geom_bar(stat = "identity")
g <- g + facet_grid(. ~ type)
print(g)
dev.off()