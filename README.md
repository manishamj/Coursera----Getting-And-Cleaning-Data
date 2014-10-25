
Coursera : Getting and Cleaning Data Project
============================================
My solutions to the project for Johns Hopkins MOOC class tought by by Jeff Leek, PhD, Brian Caffo, PhD, Roger D. Peng, PhD. for October 2014.

### Assignment
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Gradeing is by peers on a series of yes/no questions related to the project. 
Requirement is to submit:
* a tidy data set 
*	a link to a Github repository with script for performing the analysis
*	a code book that describes the variables, the data, and any transformations or work that is performed to clean up the data called CodeBook.md. 
*	a README.md in the repo with your scripts. 

This repository should explain how all of the scripts work and how they are connected.  
 
### About the raw data

**DATA ORIGIN:** https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**ORIGINAL DATA DESCRIPTION:** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

** Use of this dataset in publications must be acknowledged by referencing the following publication [1] [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

There are 2 sets of data in the zip file - train and test. As explained in the above data description, 70% subject data is in train folders & 30% in test folders.
*	The features are unlabeled and can be found in the `x_train.txt and x_test.txt`. 
*	The activity labels are in the `y_train.txt and y_test.txt` file. 
*	The subjects are in the `subject_train.txt and subject_test.txt` file.

###R SCRIPT
run_analysis.R - this script does following:
*	Load data as follows:
  * 	Check if data directory exists - if not it will create it
  * 	Check if dataset zip is downloaded, if not then download it
  * 	Check if the zip file has been unzipped, if not, unzip it
*	Read the tables in
*	Merge the train and test data corresponding tables, so we have complete 100 % data for all 30 volunteers
*	Using feature data in features.txt extract only the measurements on mean and standard deviation for each measurement. 
*	Using activity data in activity_labels.txt  add descriptive activity names to name the activities in the data set
*	Appropriately labels the data set with descriptive variable names. 
*	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Final tidyData.txt has 181 rows (heading line + 180 rows of data (30 subjects, 6 activites each) ) and 68 variables 

###PREREQUISITE
The code works with base R packages- no special packages are required.
###USAGE
```
source('./run_analysis.R')  
run_analysis()
```

###Output
Output will be the tidy data set - tidyData.txt a space deliminted file that is created in current working directory. The run_analysis.R also has commented lines at the end to read data from the file in the code again and do head() on the data to see exact data.
