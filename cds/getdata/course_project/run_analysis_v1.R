library(dplyr)


features <- read.table("./UCI HAR Dataset/features.txt")
features <- rename(features, id = V1, feature = V2)
features$feature <- as.character(features$feature)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_test <- rename(subject_test, subject = V1)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x_test2 <- x_test
names(x_test2) = features$feature    
head(x_test2)    
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
y_test <- rename(y_test, activity_id = V1)

test_data <- cbind(subject_test, y_test, x_test)


subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_train <- rename(subject_train, subject = V1)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
y_train <- rename(y_train, activity_id = V1)

train_data <- cbind(subject_train, y_train, x_train)


head(features)
summary(all_data)
all(names(x_test) == names(x_train))

all_data <- rbind(test_data, train_data)

loop_data <- head(all_data)
names(loop_data) = features$feature
head(loop_data)

p = 1

for (i in features$feature) {
    col <- paste("V",p, sep="")
    class(col)
    print(col)
    loop_data <- rename(loop_data, i = col)
    p = p+1}






















