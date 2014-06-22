gettingcleaningdata
===================

Getting and Cleaning Data - Project

Source dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

Assignment: 

A - You should create one R script called run_analysis.R that does the following.
B - Merges the training and the test sets to create one data set.
C - Extracts only the measurements on the mean and standard deviation for each measurement.
D - Uses descriptive activity names to name the activities in the data set
E - Appropriately labels the data set with descriptive activity names.
F - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
G - Notes

Specific components of the rscript : run_analysis.R

Requires the reshape2 & Plyr packages.
Assumes the dataset is unzipped in the root directory.
The following variables: mean() & std() are used.


How to use this script:

Open the run_analysis.R script in R. Select the complete file and run it.
The run_analysis.R will create 2 files: tidy.txt & tidy.mean.txt.

My system settings:

Linux x86_64
Rstudio Version 0.98.501
date: 22-06-2014



