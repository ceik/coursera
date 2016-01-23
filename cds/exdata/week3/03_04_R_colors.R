#####    Plotting and Color in R    #####
#########################################

### Problem

# Colors can make it much easier for the reader to understand your data/plot.

# The default color schemes in R are often suboptimal. This is true both from a
# design and a functional (colors are often supposed to illustrate data) POV.
#
# E.g. the default colors for the col argument are:
# 1 = Open black
# 2 = Red
# 3 = Green
#
# Default image colors are heat colors (red = low, yellow = high) or topo colors
# (blue = low, green = mid, yellow = high)

# Some packages and functions can help here.


### Color Utilities in R

# the grDevices package has two functions (colorRamp() and colorRampPalette())
# that take palettes of colors and interpolate between them.
# The function 
colors() 
# lists the names of colors that can be used in any plotting function.

# The colorRamp() takes a palette of colors as an input and returns a function
# that takes values between 0 and 1, indicating the extremes of the given color
# palette. (See also the grey() function)
# The new function returns a matrix of RGB values.

pal <- colorRamp(c("red", "blue"))
pal(0)
pal(1)
pal(0.5)
pal(seq(0,1, len=10))

# The colorRampPalette() function also takes a palette of colors as an input and
# returns a function. However this new function takes integer arguments and 
# retuns a vector of colors interpolating the palette. (Like heat.colors() and
# topo.colors())
# The new function returns a character vector of hexadecimals. In these values
# the first to digits represent red, the second two represent green, and the 
# last three represent blue. F is the highest, 0 the lowest number.

palp <- colorRampPalette(c("red", "yellow"))
palp(2)
# The following gives a total number of 10 colors between red and yellow.
palp(10)


### RColorBrewer Package

# This package contains useful color palettes for three types of data:
# Sequential data: Ordered data, e.g. going from something low to high.
# Diverging data: Showing the deviation from something (e.g. a mean or specific
#                 value).
# Qualitative data: Categorical or factor data that is not ordered.
# Palette information from this package can be used in conjunction with the 
# colorRamp() and colorRampPalette() functions.

# Lecture slides contain all color palettes in the package.

install.packages("RColorBrewer")
library("RColorBrewer")

# This also lists all available palettes:
?brewer.pal


cols <- brewer.pal(3, "BuGn")
cols
palb <- colorRampPalette(cols)
palb
library(datasets)
image(volcano, col = palb(20))


### The smoothScatter() Function

# The smoothScatter() function is very useful for plotting many points at once 
# (that would overlap each other). The function creates a 2-D histogram of the
# points in your plot and plots those histograms

x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x,y)


### Other Useful Functions

# The rgb() function converts any rgb values into hexadecimal color values, 
# which can be passed to functions that require hexadecimal then. Transparency
# can be added via the alpha argument of the rgb() function.

a <- rnorm(2000)
b <- rnorm(2000)
plot(a, b, pch = 19)
# Adding some transparancy to this will make it a bit histogram like.
plot(a, b, col = rgb(0,0,0, alpha = 0.2), pch = 19)

# The colorspace package can be used to gain different kinds of controls over
# colors. Read documentation for more info.