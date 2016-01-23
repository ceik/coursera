#####    Exploratory Graphs    #####
####################################

setwd("C:/Chris/cds/exdata/week1")

### One Dimensional Summary Techniques

pollution <- read.csv("avgpm25.csv", colClasses = c("numeric", "character",
    "factor", "numeric", "numeric"))
head(pollution)

# Five Number Summary. summary() is actually six numbers because it also cotains
# the mean.
summary(pollution$pm25)

# Boxplot
# Overlay feature: abline
boxplot(pollution$pm25, col = "blue")
abline(h=12, col = "red")

# Histogram: Adjust the breaks to fine tune granularity
# Overlay features: Rug and abline
hist(pollution$pm25, col = "green", breaks = 50)
rug(pollution$pm25)
abline(v=12, lwd=2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

# Barplot
barplot(table(pollution$region), col = "wheat", 
        main = "No. of Counties in Each Region")





### Two Dimensional Summary Techniques

pollution <- read.csv("avgpm25.csv", colClasses = c("numeric", "character",
    "factor", "numeric", "numeric"))


### Multiple/overlayed 1-D plots

# Boxplots
boxplot(pm25 ~ region, data = pollution, col = "red")

# Multiple Histograms:
# This sets parameters for the graphs below first. mfrow sets how many graphs 
# will be drawn and how they are arranged: By c(nr, nc). mar sets the margins 
# on the four sides of the plot: c(bottom, left, top, right)
par(mfrow = c(2,1), mar = c(4,4,2,1))
hist(subset(pollution, region == "east")$pm25, col="green")
hist(subset(pollution, region == "west")$pm25, col="red")

# Scatterplots
# They can also have overlay features.
with(pollution, plot(latitude, pm25))
abline(h=12, lwd=2, lty=2)


### More Than Two Dimensions

# Colored plots can be used. E.g. coloring the scatterplot above lets you add
# a third dimension.
with(pollution, plot(latitude, pm25, col = region))

# Multiple 2-D plots can also be used. Instead of coloring the scatterplot
# above, it could be split into two different ones.
par(mfrow = c(1,2), mar = c(5,4,2,1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))


### Summary

# Exploratory plots are quick and dirty
# Summarize the data and highlight any broad features
# Explore basic questions and hypotheses
# Suggest modeling strategies for next steps