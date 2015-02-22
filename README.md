# Getting_Cleaning_Data

=================================================
Course Project  --- Getting and Cleaning Data
Feb. 2015
Guillermina Gavaldon
=================================================
Prepare tidy data that can be used for later analysis

Source Data:
========
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human 

Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector 

Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 

Spain. Dec 2012

-------------------------------------------------------------------------
Setting working directory:
=============================
setwd(paste(getwd(), "/COURSERA/DATOS/UCI HAR Dataset", sep=""))

Reading data:
First I read in the files and look at their dimensions
To read in the files I used the following commands and variables:

datXtrain <- read.table("train/X_train.txt") # Training set
datXtest <- read.table("test/X_test.txt")    # Test set
datYtrain <- read.table("train/y_train.txt") # Training labels
datYtest <- read.table("test/y_test.txt")    # Test labels
datStrain <- read.table("train/subject_train.txt") # Subject who performed activity 

training
datStest <- read.table("test/subject_test.txt") # Subject who performed activity test

Dimensions:
============
dim(datXtrain)
[1] 7352  561
> dim(datXtest)
[1] 2947  561
> dim(datYtrain)
[1] 7352    1
> dim(datYtest)
[1] 2947    1
> dim(datStrain)
[1] 7352    1
> dim(datStest)
[1] 2947    1

I see that datXtrain and datXtest have the same number of columns. I can bind it by rows.

Merging Data containing measured features:

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

Binding Sensor Data, creating Total data frame with headers
================================================

#Extract only measurements containing the word mean and std
total_mean <- MF[,grep("mean", names(MF), value=TRUE)]
total_std <- MF[,grep("std", names(MF), value=TRUE)]

# Merge the extracted Data frames
total_clean<-cbind(total_mean, total_std)

# Change numbers by string characters specifying the activity
MA$activity[total_activity$activity == "1"] <- "walking"
MA$activity[total_activity$activity== "2"] <- "walking_upstairs"
MAy$activity[total_activity$activity == "3"] <- "walking_downstairs"
MA$activity[total_activity$activity == "4"] <- "Sitting"
MA$activity[total_activity$activity == "5"] <- "Standing"
MA$activity[total_activity$activity == "6"] <- "laying"

#Add the activity column to the data frame
total_clean<-cbind(MA,total_clean )

#Create name of the data frame(column vector) total_activity_code in order to access it 

easier
names(total_activity)<-"activity"
#Create name to the subject data frame
names(MS)<-"subject"

#Add subject column to the data frame
total_clean<-cbind(MS,total_clean )

Total_data <- cbind(MF,MA,MS)
