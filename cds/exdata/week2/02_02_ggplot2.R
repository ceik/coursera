#####    ggplot2 Plotting System    #####
#########################################

### ggplot2 Basics

# The ggplot2 package was developed by Hadley Wickham and implements concepts
# from the Grammar of Graphics by Leland Wilkinson. It is the third very popular
# graphics system in R.
#
# Good documentation is available on http://ggplot2.org
#
# Grammar of Graphics is a concept of how to systematically create graphics from
# data. In a nutshell: The grammar tells us that a statistical graphic is a 
# mapping from data to aesthetic attributes (color, shape, size) of geometric 
# objects (points, lines, bars). The plot may also contain statistical 
# transformations of the data and is drawn on a specific coordinate system.

install.packages("ggplot2")
library(ggplot2)


### Function Basics

# qplot is a quick plotting function that hides much of the details that would
# go into ggplot. Both work much like the plot function in the base package. 
# They look for the data in a dataframe first and in the parent environment 
# second.
#
# Plots are made up of aesthetics (shape, size, color) and geoms (points, lines).
#
# Factors are important and can be used to indicate subsets of the data. Factors
# should be labeled.


### The qplot Function

str(mpg)

# Basic qplot:
qplot(displ, hwy, data = mpg)

# When using factors, qplot automatically colors them and adds a legend:
qplot(displ, hwy, data = mpg, color = drv)

# Geoms can also be added:
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

# A histogram is created when only one data variable is passed:
qplot(hwy, data = mpg, fill = drv)

# Facets are like panels. When specifying them the left side stand for the rows
# and the right side for the columns. A period means nothing in the rows/columns.
qplot(displ, hwy, data = mpg, facets = . ~ drv)
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)

# qplot() has many built-in features and makes it very easy to generate nice 
# plots quickly. It is hard to customize though. In that case ggplot() should
# be used.


### Basic Components of a ggplot2 Function

# 1. A data frame,
# 2. Aesthetic mappings: How data is mapped to color, size.
# 3. Geoms: Geometric objects like points, lines, shapes.
# 4. Facets: For conditional plots.
# 5. Stats: Statistical transformations like binning, quantiles, smoothing.
# 6. Scales: Scales of an aesthetic map (e.g. male = blue, female = red).
# 7. Coordinate system.


### Building Plots With ggplot2

# Rather than using qplot, plots can also be gradually built in ggplot2 (much
# like the artist palette approach in the base plotting system).
# First step is always plotting the data. This is followed by overlaying a
# summary and finally adding metadata and annotations.

# See lecture .pdf for an example of this approach.


### Axis Limits in ggplot2

# Setting axis limits in ggplot2 behaves differently than in the base plot
# system. The following sets axis limits in the base system for a data frame 
# with and outlier:
testdata <- data.frame(x = 1:100, y = rnorm(100))
testdata[50,2] <- 100 # Outlier!
plot(testdata$x, testdata$y, type = "l", ylim = c(-3,3))

# Doing the same for ggplot will simply exclude that point from being plotted.
g <- ggplot(testdata, aes(x=x,y=y))
g + geom_line() # No axis limit
g + geom_line() + ylim(-3,3) # ylim will subset the data to exclude all outliers!
g + geom_line() + coord_cartesian(ylim = c(-3,3)) # Same effect as in base.


### Using Facets on Continuous Variables

# Continuous variables need to be turned into categorical ones so that they can
# be conditioned on in the plot. This can be done with the cut() function.

# See lecture .pdf for an example of constructing a panel plot with this.