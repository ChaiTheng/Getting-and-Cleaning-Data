Assignment: Getting and Cleaning Data Course Project

This document explain the procedure on getting and cleaning the data and how data is tidy up. Information was obtain via the following.
The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Run analysis.R script performs the following steps to clean the data:

#Codebook
1	Read X_train.txt and y_train.txt file from ./UCI HAR Dataset/test and store to variable  X_train and y_train respectively.

2	Read X_train.txt and y_train.txt file from ./UCI HAR Dataset/test and store to variable  X_train and y_train respectively.

3	Read X_test.txt and y_test.txt file from ./UCI HAR Dataset/test and store to variable  X_test and y_test respectively.

4	Join X_train  to X_test to generate data frame call joinData. Join y_train and y_test to generate data frame call joinLabel. Join subject_train to subject_test to generate data frame call joinSubject.

5	Read features.txt file from the "/data" folder and store to variable features. We  want the measurements on the mean and standard deviation.

6	Change to upper cap letter for the first "mean" and "std" to “Mean” and “Std” and 
remove the symbols such as "()" and "-".

7	Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called activity_labels.

8	Assign all names to lower cases remove all underscore and capitalize the letter immediately after the underscore for activity names in the second column of activity. 

9	Transform the values of joinLabel according to the activity data frame

10	Name the first two columns, "subject" and "activity. Combine joinSubject, joinLabel and joinData by column to get a data frame call arrangedata.

11	Write the arrangeData out to “Output.txt” file in current working directory.

12	Tidy the data set with the average of each measurement for each activity and each subject and generate “Week4_Assignment.txt” In current working directory. 


