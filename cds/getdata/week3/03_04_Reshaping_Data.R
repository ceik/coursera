#####    Reshaping Data    #####
################################

### Remember Tidy Data Principles

# 1. Each variable form a column
# 2. Each observation forms a row
# 3. Each table/file stores data about one kind of observation

library(reshape2)
head(mtcars)


### Melting Data Frames

# Melting keeps some id columns from the data frame, while adding a variable
# column and a value column. These contain the name and value for each column of
# the data frame that was specified as a measure in the melt function. This
# process slimns down the data frame and makes it longer.

mtcars$carname <- rownames(mtcars)
car_melt <- melt(mtcars, id=c("carname", "gear", "cyl"),
                 measure.vars=c("mpg", "hp"))
head(car_melt)
tail(car_melt)


### Casting Data Frames

# A data frame that was melted can be shaped with the dcast() function. It puts
# the left side of the function into the rows and applies a function on the
# right side of the function (the default it count).

cyl_data <- dcast(car_melt, cyl ~ variable)
cyl_data
cyl_data2 <- dcast(car_melt, cyl ~ variable,mean)
cyl_data2


### Getting Aggregate Values from the Data Frame

head(InsectSprays)

# tapply() applies a certian funtion along an index. The following applies the
# function sum to count along the index spray
tapply(InsectSprays$count, InsectSprays$spray, sum)
tapply(InsectSprays$count, InsectSprays$spray, mean)

# split() splits first variable by the second variable. Combined with the lapply
# function the same result as above can be achieved, but the result will be a
# list instead of an array.
spray_split <- split(InsectSprays$count, InsectSprays$spray)
spray_split
spray_count <- lapply(spray_split, sum)
class(spray_count)

# That list can then be turned into a vector.
spray_count2 <- unlist(spray_count)
spray_count2

# The sapply() function returns a vector instead of a list.
spray_count3 <- sapply(spray_split, sum)
class(spray_count3)

# ddply() summarizes with a data fram as a result.
spray_count4 <- ddply(InsectSprays, .(spray), summarize, sum=sum(count))
class(spray_count4)
spray_count4

# Using ddply() with ave() returns a data frame of the same length as the input.
# The result could then be added back to the data frame. This comes in handy in
# cases where the a value needs to be subtracted from the mean/sum in each row.
spray_sums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum))
spray_sums
class(spray_sums)


### Other Helpful Functions

# acast(): For casting (multidimensional) arrays
# arrange(): For faster reordering without using order()
# mutate(): For adding new variables


### More Information

# plyr tutorial from the developer: 
# http://plyr.had.co.nz/09-user/
# 
# Good reshape tutorial: 
# http://www.slideshare.net/jeffreybreen/reshaping-data-in-r
# 
# Good plyr primer: 
# http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/