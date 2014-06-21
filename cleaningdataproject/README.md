The purpose of this project is to demonstrate the ability to collect, work with, 
and clean a data set. The goal is to prepare tidy data that can be used for later 
analysis. 

The data processed here represent data collected from the accelerometers from 
the Samsung Galaxy S smartphone. A full description is available here: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data for the project were obtained here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This project contains this readme, CodeBook.md which describes how the data is 
is processed, and an R script called run_analysis.R that does the following: 

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each 
measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable 
for each activity and each subject. 

To test this this script:

* Clone this repository
* Download the zipped data set linked above
* Unzip it into the cloned responsitory
* Source run_analysis.R