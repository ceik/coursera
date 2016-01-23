#####    Lattice Plotting System    #####
#########################################


### Lattice Basics

# The lattice package builds on the grid package, which implements a different
# graphics system than the base plotting system. Lattice uses this to implement
# functions that create Trellis graphics.
#
# There is no two step approach to plotting and annotation. Its all done in one
# function call.
#
# Lattice becomes very powerful when trying to create many plot quickly, as long
# as the format is the same and the default values are ok.

install.packages("lattice")


### Lattice Functions:

# xyplot(): Main function to create scatterplots.
# bwplot(): Box-and-whiskers plots (boxplots)
# histogram(): Histograms
# stripplot(): Like a boxplot but with actual points
# dotplot(): Plots dots on "violin strings"
# splom(): Scatterplot matrix; like pairs in base plotting system
# levelplot(), contourplot(): For plotting "image" data; e.g. heatmaps or 
#                             elevation data


### Lattice Scatterplot

# xyplot(y ~ x | f * g, data) is the usual format for lattice functions. y is 
# going to be plotted on the y and x on the x axis. f and g are optional 
# conditioning variables for which the * indicates interaction between them. 
# data is the dataframe for the plot.

library("lattice")

# Simple scatterplot:
xyplot(Ozone ~ Wind, data = airquality)

# Scatterplot with conditioning variable:
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))


### Lattice Behavior

# Lattice functions do not plot directly to the graphics device. Instead they
# return an object of class trellis that then needs to be printed. When printed
# the plotting will happen on the graphics device. Usually this printing 
# happens automatically by the auto-print function of the command line.
#
# Objects returned by lattice functions can theoretically be stored, however it
# usually makes more sense to just save the code and + data.

p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)
class(p)
xyplot(Ozone ~ Wind, data = airquality)


### Lattice Panel Functions

# Lattice functions have a panel function which controls what happens inside 
# each pannel of the plot. The defaults can be modified to customize this. Panel
# functions receive the x/y coordinates of the data points in their panel (along
# with any optional arguments).

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))

# Scatterplot with default panels:
xyplot(y ~ x | f, layout = c(2,1))

# Scatterplot with custom abline:
xyplot(y ~ x | f, panel = function(x,y,...){
    panel.xyplot(x,y,...)
    panel.abline(h = median(y), lty = 2)
})

# Scatterplot with regression line:
xyplot(y ~ x | f, panel = function(x,y,...){
    panel.xyplot(x,y,...)
    panel.lmline(x, y, col = 2)
})