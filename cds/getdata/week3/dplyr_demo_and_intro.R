#####    dplr Package    #####
##############################

### Data Frames

# Data Frames are a key data structure in R and statistics in general. They 
# have one observation per row and each column represents a variable,
# measure, or characteristic.
# Relational database systems are another important implementation of data frames


### dplyr Package General

# It is a distilled version of the plyr package that does not provide any new
# functionality but greatly simplifies existing functionality in R. It's very
# fast since it is written in C++
#
# The first argument of dplyr functions is always a data frame and the 
# subsequent arguments describe what to do with it. Columns can be refered to
# without the $ operator. The result of dplyr functions is always a data frame
# Data frames must be properly formatted and annotated.

library(dplyr)

chicago <- readRDS("chicago.rds")
str(chicago)
names(chicago)


### The Select Function

# The select() function returns a subset of the columns of the data frame.
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))


### The Filter Function

# The filter() fuction extracts a subset of rows from a data frame based on
# logical conditions.
chicago.f <- filter(chicago, pm25tmean2 > 30)
head(chicago.f)
chicago.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chicago.f)


### The Arrange Function

# The arrange() function orders the rows of a data frame according to the
# values in a column
chicago <- arrange(chicago, date)
head(chicago)
tail(chicago)
chicago <- arrange(chicago, desc(date))
head(chicago)
tail(chicago)


### The Rename Function

# The rename() function renames columns
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)


### The Mutate Function

# The mutate() function adds new variables/columns or transforms existing ones
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = T))
head(select(chicago, pm25, pm25detrend))


### The Group By and Summarize Function

# The group_by function allows you to split a data frame along categorical
# variables. Afterwards a summary can be created with the summarize() function 
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), 
                                            labels = c("hot", "cold")))
hotcold <- group_by(chicago, tempcat)
hotcold
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), 
          no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), 
          no2 = median(no2tmean2))


### The Pipeline Operator

# The pipeline operator %>% allows you to do some operations without having to 
# assign temporary variables along the way. Also you don't have to repeat the
# name of the data frame.
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>%
    summarize(pm25 = mean(pm25, na.rm=T), o3 = max(o3tmean2),
              no2 = median(no2tmean2))


### dplyr and non-Data Frames

# dplyr functions can be used on data.table formats and also with SQL data via
# the DBI package.




