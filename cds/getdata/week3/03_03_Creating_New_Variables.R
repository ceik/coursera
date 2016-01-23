#####    Creating New Variables    #####
########################################

### General

# Common variables that are created are:
#       indicators for missing data, 
#       indicators that "cut" up quantitative variables into factors, 
#       transformations of other variables

setwd("C:/Chris/cds/getdata/week3")


### Data Set to be used from Open Baltimore

download.file(
    "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD",
    destfile = "baltrest.csv")

rest_data <- read.csv("baltrest.csv")


### Creating Sequences

# Basically creates an index to your data. Three ways to specify sequence via 
# the seq() function: Using by:
s1 <- seq(1,10, by=2)
s1
# or using length (indicating the number of values that should be created):
s2 <- seq(1,10, length=3)
s2
# or using along, which creates a vector of the same length as another vector,
# starting at 1 and in steps of 1
x <- c(1,3,8,25,100)
s3 <- seq(along = x)
s3


### Subsetting Variables

# Boolean variables can be created using logical comparison against values or
# lists:
rest_data$near_me = rest_data$neighborhood %in% c("Roland Park", "Homeland")
table(rest_data$near_me)

# They can also be created by using an ifelse function. However the resulting
# variable doesn't have to be a boolean.
rest_data$zip_wrong = ifelse(rest_data$zipCode <0, TRUE, FALSE)
table(rest_data$zip_wrong, rest_data$zipCode < 0)


### Creating Categorical Variables

# They can be created with the cut() function, which creates a factor variable
rest_data$zip_groups = cut(rest_data$zipCode, 
                           breaks = quantile(rest_data$zipCode))
table(rest_data$zip_groups)
table(rest_data$zip_groups, rest_data$zipCode)

# The cut2() function from automatically cuts into g groups, making them a
# qunatile each.
library(Hmisc)
rest_data$zip_groups2 = cut2(rest_data$zipCode, g=4)
table(rest_data$zip_groups2)

# Cutting creates a factor variable
class(rest_data$zip_groups2)


### Creating Factor Variables

# Sometimes numerical values should be turned into factors, so that some
# mathematical operations are not performed on them:
rest_data$zcf <- factor(rest_data$zipCode)
rest_data$zcf[1:10]
class(rest_data$zcf)

# Factor variables can also be created with factors in a certain order. Either 
# by specifiying the labels explicitly or by using the relevel() function after
# the factor was created. The level indicated as ref will be the first level.
yesno <- sample(c("yes", "no"), size=10, replace=T)
yesnofac = factor(yesno, levels=c("yes", "no"))
yesnofac
relevel(yesnofac, ref="no")

# A factor can be turned back into a numeric value. The lowest value (first in
# the list of levels) will be the number one, and so forth.
as.numeric(yesnofac)


### Creating a New Variable via Mutation

# Mutation creates a new data frame into which the new variable will be added.
library(Hmisc); library(plyr)
rest_data2 <- mutate(rest_data, zip_groups3 = cut2(zipCode, g=4))
table(rest_data2$zip_groups3)


### Common Transformations:

# abs(x)                -> absolute value
# sqrt(x)               -> square root
# ceiling(x)            -> rounding up to nearest int
# floor(x)              -> rounding down to nearest int
# round(x, digits=n)    -> rounding with 2 decimals
# signif(x, digits=n)   -> rounding with 2 significant digits
# cos(x); sin(x)        -> sine and cosine
# log(x)                -> natural log
# log2(x); log10(x)     -> other logs
# exp(x)                -> exponentiating x


### Other good sources:

# http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
# http://statmethods.net/management/functions.html
# http://plyr.had.co.nz/09-user/























