#####    Course Project 1 - Plot 2    #####
###########################################

setwd("C:/Chris/cds/exdata/cp2")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


### Aggregate Data

balt <- nei[nei$fips == "24510", ]
sums_b_y <- tapply(balt$Emissions, balt$year, sum)


# Plot 2
png(filename = "plot2.png", width = 480, height = 480)
barplot(sums_b_y, main = "Emissions of PM2.5 in tons in Baltimore")
dev.off()