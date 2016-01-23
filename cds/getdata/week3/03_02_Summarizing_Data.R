#####    Summarizing Data    #####
##################################


setwd("C:/Chris/cds/getdata/week3")

### Data Set to be used from Open Baltimore

download.file(
    "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD",
    destfile = "baltrest.csv")

rest_data <- read.csv("baltrest.csv")


### Summarizing 

# Looking at the first/last n rows of the data.
head(rest_data, n=3)
tail(rest_data, n=3)

# Using the summary() function often lets you spot anomalies with the data.
# E.g. there is a negative zip code and a non integer council district.
summary(rest_data)

# str() function provides details about the structure of the data frame and the
# data type of its columns.
str(rest_data)

# You can look at the quantiles of quantitative data as well.
quantile(rest_data$councilDistrict, na.rm = T)
quantile(rest_data$councilDistrict, probs = c(0.5, 0.75, 0.9))

# Data can be summarized in a table. Specifying useNA will add a column that
# counts the number of NAs.

table(rest_data$zipCode, useNA = "ifany")
table(rest_data$zipCode, useNA = "always")

# Tables can also be two-dimensional.

table(rest_data$councilDistrict, rest_data$zipCode)


### Checking for Specific or Missing Values

# Checking for NAs
is.na(rest_data$councilDistrict)
sum(is.na(rest_data$councilDistrict))
any(is.na(rest_data$councilDistrict))
colSums(is.na(rest_data))

# Checking for negative or NA values with the all() function. It checks whether
# all values statisfy the condition.
all(rest_data$zipCode > 0)
all(colSums(is.na(rest_data))==0)

# Find specific values with %in%
table(rest_data$zipCode %in% c("21212", "21213"))

# A logical vector with %in% can also be used to subset a dataset
rest_data[rest_data$zipCode %in% c("21212", "21213"), ]


### Cross Tabs

# Cross Tabs explain one variable by one or multiple other ones
data(UCBAdmissions)
df = as.data.frame(UCBAdmissions)
summary(df)

xt1 <- xtabs(Freq ~ Gender, data = df)
xt1
xt2 <- xtabs(Freq ~ Gender + Admit, data = df)
xt2

# Flat tables are helpful when cross tabs would have to be used on more than
# two variables

data(warpbreaks)
head(warpbreaks)
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~ ., data = warpbreaks)
xt
ftable(xt)


### Size of a Dataset

fakedata <- rnorm(1e5)
object.size(fakedata)
print(object.size(fakedata), units = "Mb")
print(object.size(fakedata), units = "Kb")













