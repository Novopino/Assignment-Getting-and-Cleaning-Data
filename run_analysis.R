library(plyr)

# Setting the working directory for the assignment and creating "data" folder
setwd("N:/Getting-and-Cleaning-Data")
if(!file.exists("./data")){dir.create("./data")}

# Downloading the data from the website to the "data" folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unziping the data
unzip(zipfile="./data/Dataset.zip",exdir="./data")
if (file.exists("./data/Dataset.zip")) file.remove("./data/Dataset.zip")

# Reading and merging the data

# Reading training data
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing data
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Assigning column names
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merging all data
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
mergeAll <- rbind(merge_train, merge_test)

# Extracting only the measurements on the mean and standard deviation for each measurement
# Reading column names
colNames <- colnames(mergeAll)

# Create vector for defining ID, mean and standard deviation
mean_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
                   )

# Making subset from mergeAll
setForMeanStd <- mergeAll[ , mean_std == TRUE]

# Using descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setForMeanStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# Creating a second, independent tidy data set with the average of each variable for each activity and each subject

# Making tidy data set
TidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
TidySet <- TidySet[order(TidySet$subjectId, TidySet$activityId),]

# Writing tidy data set in a txt file
write.table(TidySet, "TidySet.txt", row.name=FALSE)