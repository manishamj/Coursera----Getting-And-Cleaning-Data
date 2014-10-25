CodeBook for the Project - Coursera Getting and cleaning data
==============================================================

Data
====

The original data, derived from the "Human Activity Recognition Using Smartphones Data Set",comes from the smartphone accelerometer and gyroscope 3-axial raw signals, which have been processed using various signal processing techniques to measurement vector consisting of 561 features. 

Source
-------

This dataset is which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Description
-----------

Description is given at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Also,  detailed description of the original dataset can be seen at features_info.txt in the zipped dataset file. 

Activities
==========

Refer to activity_labels.txt for the description and mapping of the activity lables. 
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

Feature Information
===================

In  features_info.txt the description of features is given. 
Per this text file,  the features selected for features.txt comes from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).
These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables estimated were:
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values.
iqr(): Interquartile range
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal
kurtosis(): kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Project steps
=============

Following steps were performed for the project:
1.   The data tables in train and test folders were merged into join data set to create complete data set with all 30 subjects. 
    •	X_joinData, created by merging  X_train.txt and X_test.txt, is a 561 feature vector with time and frequency domain variables and dimention of 10299 rows and 561 column.
    •	Y_joinData, created by merging  Y_train.txt and Y_test.txt, is the activity, has values 1-6 and dimention of 10299 rows and 1 column.
    •	The sub_joinData, created by merging  subject_train.txt & subject_text.txt,  is identity of person involved in study has values 1-30  with dimention of 10299 rows and 1 column

2.  The subset of the data with only mean and std deviation was taken.
    •	After inspecting some rows of the join data set, it was determined that the columns with mean() and std() were needed to be selected for  the subset required for this project.  This selected 66 columns from X_joinData.  
    •	I also removed "()" and "-" from the column names for more readability.
    •	Changed column names by substituting ^t with "time" and ^f with "freq" for readability.
    •	This gave new X_joinData with 10299 rows and 66 columns.

3.  In Y_joinData replaced activity value with descriptive activity label and named the column as Activity.
4.  In sub_joinData, named the column as "Subject".
5.  Created cleanedData by combining sub_joinData, Y_joinData and X_joinData.  
6.  Then created independent tidy data set with  the average of each variable for each activity and each subject using aggregate and wrote out the resulting table in file in current directoty as "tidyData.txt"

TIDY DATA
=========

The end result of project is a file named tidyData.txt which is a space delimited file written to the current working directory. It will have 181 rows (1 heading row + 180 data rows for 30 subjects and 6 activities per subject) wih 68 columns (1 column for subject + 1 column for activity +  66 mean and standard deviation columns). The original  data was subsetted and  aggregrated resulting in a tidy data set with the average of each variable for each activity and each subject.
