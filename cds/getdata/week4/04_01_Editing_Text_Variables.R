#####    Editing Text Variables    #####
########################################

### Getting the Data for this Section

setwd("C:/Chris/cds/getdata/week4")
fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileurl, destfile = "cam_data.csv")
cam_data <- read.csv("cam_data.csv")


### Upper and Lower Case Conversion

names(cam_data)
tolower(names(cam_data))
toupper(names(cam_data))


### Splitting Strings

# The escape character needs to be used because . is a reserved character
split_names <- strsplit(names(cam_data), "\\.")
split_names
split_names[[6]]

# strsplit() seems to create a list
sn <- names(cam_data)
class(split_names[6])
class(sn)
class(split_names[[6]])


### Lists: Quick Review

# Create a list with three components: 1 named character vector, 1 named 
# numeric vector, and 1 unnamed matrix
my_list <- list(letters = c("a", "b", "c"), numbers = 1:3, matrix(1:25, ncol=5))
my_list

# Subsetting that list
my_list[1]
my_list$letters
my_list[[1]]
class(my_list[1])
class(my_list$letters)
class(my_list[[1]])


### The sapply Function

# sapply() applies a function to each element in a vector or list
split_names[[6]][1]
first_element <- function(x) {x[1]}
sapply(split_names, first_element)


### Getting the Peer Review Data Set

setwd("C:/Chris/cds/getdata/week4")
url1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
url2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(url1, destfile = "reviews.csv")
download.file(url2, destfile = "solutions.csv")
rev <- read.csv("reviews.csv")
sol <- read.csv("solutions.csv")
head(rev)
head(sol)


### Replacing Characters

names(rev)

sub("_","",names(rev),)

# The sub() function only replaces the first occurance of your pattern in each 
# value. Use gsub() to replace all occurances.

test <- "this_is_a_test_variable"
sub("_","",test)
gsub("_","",test)


### Finding Values

# grep() will return the position of the occurance, while grepl() will return
# a logical vector for each searched value.
grep("Alameda", cam_data$intersection)
grepl("Alameda", cam_data$intersection)
table(grepl("Alameda", cam_data$intersection))

# grepl() can then also be used to subset the data
cam_data2 <- cam_data[!grepl("Alameda", cam_data$intersection),]

# Setting value = TRUE will make grep() return the value that contains the 
# pattern.
grep("Alameda", cam_data$intersection, value = T)

# grep() returns and empty integer when it can not find a value. That empty 
# integer has length 0, which is very convenient for checks.
grep("Jeff Street", cam_data$intersection)
length(grep("Jeff Street", cam_data$intersection))


### Additional String Functions

# This library contains many useful string functions
library(stringr)

nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1,7)
paste("Jeffrey", "Leek")
paste("Jeffrey", "Leek", sep = "Joooo")
paste0("Jeffrey", "Leek")
str_trim("Jeff             ")


### Variable Best Practices

# Variable names should be all lower case if possible, descriptive (diagnosis
# vs. dx), not duplicated, and not have underscores, dots, or whitespace.
#
# Variables with character values should usually be made into factor variables
# (depending on application) and should also be descriptive: TRUE/FALSE vs. 0/1
# and male/female vs. m/f or 0/1.





































