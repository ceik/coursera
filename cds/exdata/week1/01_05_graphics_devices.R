#####    Graphics Devices in R    #####
#######################################

### What is a Graphics Device?

# When a plot is made in R it has to be sent somewhere (doesn't appear in the 
# console). A Graphics device is something where you can make a plot appear:
#   1. Screen device: A window on your screen
#   2. File devices: E.g. PDF, PNG, JPEG, or a scalable vector graphics file (SVC)
# 
# Available graphics devices can be listed with
?Devices
# and additional devices are available on CRAN.
#
# Functions like plot (base), xyplot (lattice), or qplot (ggplot2) will by 
# default send the plot to the screen device. For plots that are to be
# included in a document (paper, presentation, etc) a file device is usually
# more appropriate.


### How Does a Plot Get Created?

# This depends on the graphics device used. For the screen device:
#   1. Call a plot function like plot, xyplot, or qplot
#   2. The plot appears on the screen device
#   3. Annotate plot if necessary
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser Data")
#
# For file devices:
#   1. Explicitly launch a graphics device
#   2. Call a plotting function to make a plot (which won't appear on the screen)
#   3. Annotate plot if necessary
#   4. Explicitly close graphics device with dev.off() (very important!)
library(datasets)
pdf(file = "myplot.pdf")
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser Data")
dev.off()


### Different Graphics File Devices

# Type 1: Vector devices. These use geometrical primitives instead of pixels
#         to represent images. This means the graphic can be rezised extremely
#         well. Plots with many points are not very size efficient as every
#         points is its own object. Different vector formats are: 
#           - pdf: Very portable
#           - svg: XML-based, supports animation and interactivity, useful for
#                  web-based plots
#           - win.metafile
#           - postscript
# Type 2: Bitmap devices. Graphics are represented via pixels. Good for plots
#         with many points/objects. However bitmaps don't resize well. Some
#         common formats are:
#           - png: Uses lossless compression which leads to small file size,
#                  most browsers can read png
#           - jpeg: Uses lossy compression. Bad for line drawing. Very portable.
#           - tiff
#           - bmp: Native Windows format


### Multiple Open Graphics Devices

# Multiple graphics devices can be open at the same time. However plotting can
# only happen on one device at a time: The currently active one. Calling
# dev.cur() will show which one os active. dev.set(<integer>) will change the 
# device to the one with the given integer. 
dev.cur()

### Copying Plots

# dev.copy() can be used to create a copy of a plot from one device to another.
# de.copy2pdf is specifically for copying to pdf. Copying a plot is not an
# exact operation, so the results might not be identical to the original.

library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser Data")
dev.copy(png, file = "geyserplot.png")
dev.off()