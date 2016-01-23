#####    Course Project 1 - Plot 4    #####
###########################################

setwd("C:/Chris/cds/exdata/cp2")
library(ggplot2)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$type <- as.factor(nei$type)
nei$year <- as.factor(nei$year)

### Aggregate Data

nei_l <- merge(nei, scc, by.x = "SCC", by.y = "SCC", all = TRUE)
comb <- nei_l[grep("^(Int|Ext) Comb", nei_l$Short.Name),]
comb_coal <- comb[grep("Coal", comb$Short.Name),]
sums_coal <- round(tapply(comb_coal$Emissions, comb_coal$year, sum)/1000)

# Plot 4

png(filename = "plot4.png", width = 480, height = 480)
barplot(sums_coal, main = "Emissions from Coal Combustion in thousand tons")
dev.off()