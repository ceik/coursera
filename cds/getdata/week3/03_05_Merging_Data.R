#####    Merging Data    #####
##############################

setwd("C:/Chris/cds/getdata/week3")
url1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
url2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(url1, destfile = "reviews.csv")
download.file(url2, destfile = "solutions.csv")
reviews <- read.csv("reviews.csv")
solutions <- read.csv("solutions.csv")
head(reviews)
head(solutions)


### Merging General & Dataset

# Merging datasets is similar to joins in SQL. The reviews data above has a
# solution_id, via which it can be matched to the solutions data.


### The Merge Function

# The merge() function can merge two data frames. It takes:
# - The two data frames
# - The columns via which the join should happen:
#       - by.x: column in the first data set that should be used for the merge
#       - by.y: column in the second data set that should be used for the merge
# - The all parameter, which indicates whether additional rows should be created
#   for values that exist in one, but not the other data frame. That row will
#   contain NAs for the missing values.
merged_data <- merge(reviews, solutions, by.x = "solution_id",
                     by.y = "id", all = TRUE)
head(merged_data)

# The id column in the remaining table is the one from the reviews data. The
# solution_id column now stands for both the solution_id column in reviews and 
# the id column in solutions.

# By default the merge() function merges by all common columns, which might not
# be correct.

intersect(names(solutions), names(reviews))
merged_data2 <- merge(reviews, solutions, all=T)
head(merged_data2)


### The Join Function

# The join() function from the plyr package is faster, however you can only 
# join by common column names. By default it does a left join.
df1 <- data.frame(id=sample(1:10), x=rnorm(10))
df2 <- data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1, df2), id)

# The join_all() function can join together multiple datasets at once. They have
# to be in a list though (and have common columns).
df3 <- data.frame(id=sample(1:10), z=rnorm(10))
df_list = list(df1, df2, df3)
join_all(df_list)


### More Information Sources

# Overview on merging: http://www.statmethods.net/management/merging.html
# plyr information: http://plyr.had.co.nz/
# Background on joins: http://en.wikipedia.org/wiki/Join_(SQL))