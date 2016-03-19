# ........................................................
# Assignment: Getting and Cleaning Data Course Project   .
# ........................................................

# Merges the training and the test sets to create one data set.
# setwd("C:/Users/username/Desktop")

if (!file.exists("getdata-projectfiles-UCI HAR.zip"))
{
  zipfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(zipfile,"getdata-projectfiles-UCI HAR.zip")
}

if(file.exists("getdata-projectfiles-UCI HAR.zip"))
{
  unzip("getdata-projectfiles-UCI HAR.zip")
}
  

# setwd("C:/Users/username/Desktop/UCI HAR Dataset")
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt") 


joinData <- rbind(X_train, X_test)
joinLabel <- rbind(y_train, y_test)
joinSubject <- rbind(subject_train, subject_test)


# Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
mean_and_Std <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, mean_and_Std]
names(joinData) <- gsub("\\(\\)",'', features[mean_and_Std, 2]) 
names(joinData) <- gsub('-mean', 'Mean', names(joinData)) 
names(joinData) <- gsub('-std', 'Std', names(joinData))
names(joinData) <- gsub('[-()]', '', names(joinData)) 

# Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt")
activity_labels[, 2] <- tolower(gsub("_", "", activity_labels[, 2]))
activityLabel <- activity_labels[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Appropriately labels the data set with descriptive variable names 

names(joinSubject) <- "subject"
arrangedata <- cbind(joinData,joinSubject, joinLabel)
write.table(arrangedata, "Output.txt")
