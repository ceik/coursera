#####    Course Project 1 - Plot 1    #####
###########################################

setwd("C:/Chris/cds/exdata/cp2")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


### Aggregate Data

sums_y <- tapply(nei$Emissions, nei$year, sum)
sums_y_k <- round(sums_y/1000)


# Plot 1
png(filename = "plot1.png", width = 480, height = 480)
barplot(sums_y_k, main = "Emissions of PM2.5 in thousand tons")
dev.off()