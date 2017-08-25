Getting and Cleaning Data: Course Assignment

This repository contains the R code for the Getting and Cleaning Data (Coursera.com) final assignment.

Files:
(1) CodeBook.md describes the variables
(2) run_analysis.R contains the code to perform the whole analyses. The output file is called "TidySet.txt"

The R script firstly downloads the source data from the link and unzips it.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R code generally performs five steps in accordance with the assigment. It is commented directly in the script "run_analysis.R" as well.

It reads the unzipped tables.
Then it assignes column names and merges all the data in one set.
Then it extracts the measurements on the mean and standard deviation for each measurement only.
It creates a vector for defining ID, mean and standard deviation.
It creates tidy data set with the average of each variable for each activity and each subject.
