#####    Working With Dates    ######
#####################################

### Date Function

# The date function returns the current datetime as a character variable.
d1 <- date()
d1
class(d1)


### sys Date Function

# The Sys.Date() function returns the current date as a date variable.
d2 <- Sys.Date()
d2
class(d2)


### Formatting Date Variables

# Dates can be formatted with the format() function, which gives the following
# options:
# %d = day as a number (0-31)
# %a = abbreviated weekday
# %A = unabbreviated weekday
# %m = month as a number(1-12)
# %b = abbreviated month
# %B = unabbreviated month
# %y = 2-digit year
# %Y = 4-digit year
format(d2, "%d %a %A %m %b %B %y %Y")


### Creating Dates

# Dates can be created from text with the as.Date() function if the format is
# correctly specified.
x <- c("1Jan1960", "2Jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z


### Calculating With Dates

# Dates can be subtracted from each other.
z[1]-z[2]
as.numeric(z[1]-z[2])


### Extracting Parts of a Date Variable

weekdays(d2)
months(d2)


### Converting to Julian Date

# A julian date format counts the number of days since the origin of the format
julian(d2)


### The lubridate Package

install.packages("lubridate")
library("lubridate")

# The lubridate functions can turn a great many variables into dates,
# regardless of their format.
ymd("20150804")
mdy("08-04-15")
d3 <- dmy("04/08/2015")
d3
class(d3)

# lubridate can also handle time data in the same manner.
d4 <- ymd_hms("2015-08-04 10:15:03")
d4
class(d4)

# The time zone can also be set:
d5 <- ymd_hms("2015-08-04 10:15:03", tz="Pacific/Auckland")
d5
class(d5)

?Sys.timezone

# Some functions in lubridate have different syntax than the standard functions.
y <- dmy(x)
y
class(y)
wday(y[1])
wday(y[1], label=T)


### More Information

# lubridate tutorial:
# http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/
#
# lubridate vignette:
# http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html
#
?POSIXlt
# for more information on the date formats.