#####    The Base Plotting System in R    #####
###############################################


### Basics

# Core plotting system is encapsulated in a few packages:
# graphics: Contains functions for "basic" plotting systems, e.g. plot, hist,
#           bloxplot, etc.
# grDevices: Contains code implementing different graphics devices, e.g. X11,
#            PDF, PostScript, PNG, etc.
#
# Before starting to work on a plot, consider a few questions:
# 1: Where will the plot be made? On screen or in a file?
# 2: How will the plot be used? Only exploratory or for a paper, presentation, 
#    website, etc.?
# 3: Does is use a large amout of data or just a few data points?
# 4: Do you need to be able to dynamically resize the plot?
# 5: What plotting system to use? They can't be mixed.


### Base Graphics

# Two step process to create a plot with the base system:
# 1: Initialize the plot by calling plot(), hist(), etc. THis will lauch a
#    graphics device. These plots can be tweaked by parameters.
     ?par
#    will list and explain most of them.
# 2: Annotating an existing plot.

### Simple Base Graphics

library(datasets)
data(airquality)

# Histogram
hist(airquality$Ozone)

# Scatterplot
with(airquality, plot(Wind, Ozone))

# Boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")


### Important Parameters

# To be set as part of the plot function:
# pch: Plotting character/symbol
# lty: Line type (solid/dashed/dotted, etc)
# lwd: Line width (integer)
# col: Plotting color. colors() function gives a list of colors that can be 
#      specified by name. Colors can also be specified by number or hex code.
# xlab & ylab: Character string for the x/y-axis label 
#
# To be set in the par() function, that sets global graphics parameters. These
# can be overwritten in the plot function
# las: Orientation of the axis labels on the plot
# bg: Background color
# mar: Margin size (bottom, left, top, right)
# oma: Outer margin size (default is 0 for all sides)
# mfrow: Number of plots per row, column (plots are filled row-wise)
# mfcol: Number of plots per row, column (plots are filled column-wise)
#
# Checking default values for parameters:
par("bg")
par("mar")
par("mfrow")


### Base Plotting Functions

library(datasets)
data(airquality)

# plot: Makes scatterplot or other type, depending on the class of the object
#       being plotted
# type = "n": Using this arguement in the plot function will lead to the graphics
#             device being set up, but no data plotted
# lines: Connects dots on a plot. Takes in a vector of x-values, and one of
#        y-values or a two column matrix.
# points: Adds points to a plot.
# text: Adds text labels to a plot using specific x, y coordinates.
# axis: Adds axis ticks, labels.

# title: Adds annotations to x, y axis, title, subtitle, or outer margin
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")

# legend: Adds a legend to the plot
# points: Adds points to a plot
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City",
                      type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), 
       legend = c("May", "Other Months"))

# Regression Line: Can be added with the lm() and abline() functions
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City",
                      pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

# mtext: Adds arbitrary text to the inner or outer margins of the plot
par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main = "Ozone and Temperature")
    mtext("Ozone and Weather in New York City", outer = T)
})


### Base Plotting Demonstration

# different pch values can be displayed with
example(points)
# for points 21 - 25: Specify border color with col and fill color with bg


# Plotting different (sub)sets of data onto a scatterplot
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50, labels = c("Male", "Female"))
plot(x, y, type = "n")
points(x[g == "Male"], y[g == "Male"], pch = 21, col = "Blue", bg = "Red")
points(x[g == "Female"], y[g == "Female"], pch = 21, col = "Blue", bg = "Green")