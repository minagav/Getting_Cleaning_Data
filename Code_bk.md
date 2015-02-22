CodeBook

Source Data:
========
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The original data source can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

DATA
=========================================================================
There is a data set: 
train/X_train.txt 	--Training set
train/y_train.txt 	-- Training data label
train/subject_train.txt	-- Subject who performed activity training

test/X_test.txt -- Test set
test/y_test.txt -- Test data label
test/subject_test.txt Subject who performed activity test

features.txt --- data set of features

Dimensions
=====================================================================
features.txt 		-- [1,561]
X_train.txt  		-- [7352,561]
y_train.txt  		-- [7352,1]
subject_train.txt 	-- [7352,1]
X_test.txt 		-- [2947,561]
y_test.txt  		-- [2947,1]
subject_test.txt	-- [2947,1]

Data Transformation
====================================================================

Merging data with the same number of columns
Files containing the measured features:

MF states of -- Measured Features
===========================================
MF <- rbind(datXtrain, datXtest)

Merging Data Containing measured Activities:

MA states of Measured Activities
================================

MA <- rbind(datYtrain, datYtest)

Linking measurements with corresponding subject

MS states of Measurements Subjects
===========================================
MS <- rbind(datStrain, datStest)

Heading data frames:
==========================================
subject <- c("Subject")
activity <- c("ActivityId")

names(MS) <- subject
names(MA) <- activity

features<-read.table("features.txt")
features<-features[,2]
names(MF)<-features
=======================================
DATA TRANSFORMATION
====================================================================

Merging data with the same number of columns
Files containing the measured features:

X_test<-read.table("X_test.txt")
X_train<-read.table("X_train.txt")

# Merge both data frames together

total<-rbind(X_train, X_test)

total 	-- 10299 obs. of 561 variables

# We are interested on the files containing the measured activities:
y_train<-read.table("y_train.txt")
y_test<-read.table("y_test.txt")
# Merge both data frames together
total_activity<-rbind(y_train, y_test)

total_activity --- 10299 obs of 1 variable


# Files containing info about which measurements correspond to which subject:
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")
# Merge both data frames together
total_subjects<-rbind(subject_train, subject_test)

