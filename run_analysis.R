# ........................................................
# Assignment: Getting and Cleaning Data Course Project   .
# ........................................................

# 1.Merges the training and the test sets to create one data set.
# setwd("C:/Users/username/Desktop/UCI HAR Dataset")

subject_train <- read.table("train/subject_train.txt")

X_train <- read.table("train/X_train.txt")

y_train <- read.table("train/y_train.txt")

X_test <- read.table("test/X_test.txt")

y_test <- read.table("test/y_test.txt") 

subject_test <- read.table("test/subject_test.txt")

joinData <- rbind(X_train, X_test)
joinLabel <- rbind(y_train, y_test)
joinSubject <- rbind(subject_train, subject_test)


# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
mean_and_Std <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, mean_and_Std]
names(joinData) <- gsub("\\(\\)", "", features[mean_and_Std, 2]) 
names(joinData) <- gsub("mean", "Mean", names(joinData)) 
names(joinData) <- gsub("std", "Std", names(joinData))
names(joinData) <- gsub("-", "", names(joinData)) 

# 3.Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt")
activity_labels[, 2] <- tolower(gsub("_", "", activity_labels[, 2]))
substr(activity_labels[2, 2], 8, 8) <- toupper(substr(activity_labels[2, 2], 8, 8))
substr(activity_labels[3, 2], 8, 8) <- toupper(substr(activity_labels[3, 2], 8, 8))
activityLabel <- activity_labels[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names

names(joinSubject) <- "subject"
arrangedata <- cbind(joinData,joinSubject, joinLabel)
write.table(arrangedata, "Output.txt")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


Length_of_column <- dim(arrangedata)[2]
Length_of_activity <- dim(activity_labels)[1] 
Length_of_subject <- length(table(joinSubject))

Output <- matrix(NA, nrow=Length_of_subject*Length_of_activity, ncol=Length_of_column) 
Output <- as.data.frame(Output)

row <- 1
for(i in 1:Length_of_subject) {
  for(j in 1:Length_of_activity) {
    Output[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    Output[row, 2] <- activity_labels[j, 2]
    Store1 <- i == arrangedata$subject
    Store2 <- activity_labels[j, 2] == arrangedata$activity_labels
    Output[row, 3:Length_of_column] <- colMeans(arrangedata[Store1&Store2, 3:Length_of_column])
    row <- row + 1
  }
}
head(Output)
write.table(Output, "Week4_Assignment.txt") 
