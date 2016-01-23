library(dplyr)

# Load label & variable name data

act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
act_labels <- rename(act_labels, id = V1, activity = V2)

features <- read.table("./UCI HAR Dataset/features.txt")
features <- rename(features, id = V1, feature = V2)
features$feature <- as.character(features$feature)

# Load & rename test data

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_test <- rename(subject_test, subject = V1)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_test) = features$feature
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
y_test <- rename(y_test, activity_id = V1)

test_data <- cbind(subject_test, y_test, x_test)

# Load & rename train data

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_train <- rename(subject_train, subject = V1)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_train) = features$feature
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
y_train <- rename(y_train, activity_id = V1)

train_data <- cbind(subject_train, y_train, x_train)

# Combine train and test data

all_data <- rbind(test_data, train_data)

# Add proper activity labels and remove activity_id

merged <- merge(all_data, act_labels, by.x = "activity_id", 
                    by.y = "id", all=F)

shrunk <- subset(merged, select = -activity_id)
shrunk_ordered <- shrunk[,c(1,563,2:562)]

# Extract relevant columns

rel_data_temp <- shrunk_ordered[, c(1:2, grep("mean()", names(shrunk_ordered)),
                                     grep("std()", names(shrunk_ordered)))]
# Excluded the meanFreq columns, but not 100% sure if they ere to be 
# included or not.
rel_data <- rel_data_temp[, -grep("meanFreq()", names(rel_data_temp))]

# Group the relevant data by subject and activity, taking the mean for every
# variable

grouped <- group_by(rel_data, subject, activity)
final <- summarise_each(grouped, funs(mean))
write.csv(final, file = "output.csv")
write.table(final, row.names=F, file = "submission.txt")
