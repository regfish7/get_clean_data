# get_clean_data
This repository saves the final project for the "Getting and Cleaning Data" Course in the JHU Data Science Specialization through Coursera.

## README ##

**DATA**

The data for this project comes from the "Human Activity Recognition Using Smartphones Dataset - Version 1.0", available through the linked [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Information about how this data was collected can be found at the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) website. In summary, the data comes from an experiment of 30 volunteers between the ages of 19-48. The participants performed 6 different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a Samsun Galaxy S II and then accelerometer and gyroscope data was collected. 

The citation for this dataset is: 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

**CONTENTS**

This repository contains the following files:

* README.md
* run_analysis.R
* CodeBook.md
* tidydata.txt
 
 The descriptions of the files are as follows:
 
* *README.md*: Gives an overview of the files in the project and the dataset itself
* *run_analysis.R*: This script creates a tidy dataset from the UCI HAR Dataset zip file listed above
 (under "DATA") by:
 
    * Merging the training and tests sets to create one data set
    * Extracting only the data points that give the mean and standard deviation of each measurement
    * Renaming the activities and variables to be more descriptive
    * Creating a second tidy data set with the average of each variable for each activity and each subject. 
 * *CodeBook.md*: This code book describes the variables, the data, and the transformations used to produced tidydata.txt, the cleaned data. 
 * *tidydata.txt*: The tidy dataset produced in run_analysis.R. Each row represents the average readings for each measurement for a given subject and activity. 
 
