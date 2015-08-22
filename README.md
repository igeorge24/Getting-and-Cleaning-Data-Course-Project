# Getting and Cleaning Data Course Project: using run_analysis.R to create a tidy dataset

## Introduction

This file describes how the run_analysis.R script creates a tidy data set from the original dataset given in the Course Project. Before the script can be run, the zip file of the dataset must be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped. The unzipped folder must be located in the R working directory. Note that the data files and folders must be in their original location and unaltered for the script to run properly. The dplyr package must be loaded into R before running the script.

## Description of run_analysis.R script and run instructions

To create a tidy data set as described in the CodeBook.md file, run the entire run_analysis.R script in R. The final result is a tidy dataset output into a text file named tidy_data.txt created in the working directory.  The run_analysis.R script performs this task in 6 steps as described below:

1. Reads in txt files

The script reads in all text files needed to create a tidy dataset, including: 

* "features.txt"  : variable names for all 561 features
* "activity_labels.txt"  : activity names that link to activity labels
* "subject_test.txt" : subject labels for test data
* "y_test.txt" : activity labels for test data
* "X_test.txt" : feature vectors for test data
* "subject_train.txt" : subject labels for train data
* "y_train.txt"  : activity labels for train data
* "X_train.txt"  : feature vectors for train data

2. Combines all data tables into one table

The script uses cbind to combine feature vector data, subject and activity labels for train and test datasets. Then the two tables are combined using rbind.

3. Changes activity labels to names based on lookup table of activity names

A vector is created that serves as a lookup table linking activity labels to activity names. The vector is used to change the activity labels in the second column of the combined dataset to activity names.

4. Changes column names to correct variable names

The column names of the combined dataset are changed to "Subject_ID", "Activity" and the variable names in "feature.txt".

5. Subsets mean and std columns from all_data

A vector of index values corresponding to the row indices of mean and std variables in the features.txt is created. The vector is used to subset these variables and the first two columns out of the combined dataset. This creates a subset dataset that includes only the first two identifier columns and the 86 mean and std feature variable columns. The subset dataset is then ordered by "Subject_ID" and "Activity".

6. Creates tidy data table summarizing mean values for each measurement by subject and activity

The final step calls dplyr package to group the subset data by "Subject_ID" and "Activity" using group_by function. The summarise_each function is used to average each feature variable over each group into another data table. Finally, this resulting summarized data table is written into a text file tidy_data.txt in the working directory.