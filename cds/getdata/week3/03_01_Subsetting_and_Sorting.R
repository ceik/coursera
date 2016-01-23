#####    Subsetting and Sorting    #####
########################################


### Subsetting Review

# Set seed and create data frame
set.seed(13435)
x <- data.frame("var1" = sample(1:5), "var2" = sample(6:10),
                "var3" = sample(11:15))
# Scramble the order of the data frame
x <- x[sample(1:5),]
# Insert some NAs
x$var2[c(1,3)] = NA
x

# Selecting a specific column can be done via its index or name:
x[, 1]
x[, "var1"]

# Selecting a specific row can be done via its index. The two methods can also
# be combined.
x[1, ]
x[1:2, "var2"]


### Subsetting with Logical Operators

# Subbsetting by column value
x[x$var1 <=3,]

# And (&) and or (|) operators can be used.
x[(x$var1<= 3 & x$var3 > 11),]
x[(x$var1<= 3 | x$var3 > 13),]

# NAs have to be filtered out using the which() function.
# This will include NA rows:
x[x$var2 > 8,]
# This won't:
x[which(x$var2 >8),]


### Sorting Values

# The sort function will sort values in increasing order by default:
sort(x$var1)
# Setting the decreasing parameter will sort in descending order instead:
sort(x$var1, decreasing = T)
# Setting the na.last parameter will put NAs at the end:
sort(x$var2, na.last = T)


### Ordering a Data Frame

# Data frames can be ordered by values of their columns using the order() function
x[order(x$var1),]
# They can be ordered using multiple columns as well. So in case of parity for
# the first column it orders by the values of the second column.
x[order(x$var1, x$var3),]

# A data frame can also be ordered using plyr and its arrange() funtion
library(plyr)
arrange(x, var1)
# Arrange() can also order in descending order
arrange(x, desc(var1))


### Adding Rows and Columns

# Adding a column by specifying a new column via its name
x$var4 <- rnorm(5)

# Adding a column to the left/right of the data frame with cbind
y <- cbind(x, rnorm(5))
y <- cbind(rnorm(5), x)

# Adding a row at the beginning or end of the data frame with rbind
z <- rbind(x, rnorm(5))
z <- rbind(rnorm(5), x)















