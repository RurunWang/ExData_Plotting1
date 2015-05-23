## Load the dplyr package
library(dplyr)

## Set working directory to the dataset folder
setwd("~/Coursera/UCI HAR Dataset")

## Read all the txt files
X_train <- read.table("train/X_train.txt")
X_test <- read.table("test/X_test.txt")
Y_train <- read.table("train/y_train.txt")
Y_test <- read.table("test/y_test.txt")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")

## Combine the training and testing data
X_all <- rbind(X_train, X_test)
Y_all <- rbind(Y_train, Y_test)
subject_all <- rbind(subject_train, subject_test)

## Merge Y_all data to the activity labels
colnames(activity_labels) <- c("V1", "Activity")
subject <- rename(subject_all, subject = V1)
Y_subject <- cbind(Y_all, subject)
Y_merge <- merge(Y_subject, activity_labels, by = ("V1"))

## Merge Y_merge data with X_all data to form a complete data set
colnames(X_all) <- features[,2]
data_all <- cbind(Y_merge, X_all)
## Remove the first column of the complete data set
data_all2 <- data_all[, -1]

## Select columns that contains means and std
data_select <- select(data_all2, contains("subject"), contains("Activity"), contains("mean"), contains("std"))

## Group them by subject and activity labels
data_group <- group_by(data_select, subject, Activity)

## Get the mean of each group
data_final <- summarise_each(data_group, funs(mean))

## Print the final result
write.table(data_final, "./run_analysis.txt", sep = " ", row.name = FALSE)