
# activity_labels<-read.table("activity_labels.txt")
# body_acc_x_test<-read.table("body_acc_x_test.txt")
# body_acc_x_test<-read.table("body_acc_x_test.txt")
# body_acc_x_train<-read.table("body_acc_x_train.txt")
# body_acc_y_test<-read.table("body_acc_y_test.txt")
# body_acc_y_train<-read.table("body_acc_y_train.txt")
# body_acc_z_train<-read.table("body_acc_z_train.txt")
# body_acc_z_test<-read.table("body_acc_z_test.txt")
# body_gyro_z_test<-read.table("body_gyro_z_test.txt")
# body_gyro_z_train<-read.table("body_gyro_z_train.txt")
# body_gyro_y_test<-read.table("body_gyro_y_test.txt")
# body_gyro_y_train<-read.table("body_gyro_y_train.txt")
# body_gyro_x_train<-read.table("body_gyro_x_train.txt")
# body_gyro_x_test<-read.table("body_gyro_x_test.txt")
# total_acc_x_test<-read.table("total_acc_x_test.txt")
# total_acc_y_test<-read.table("total_acc_y_test.txt")
# total_acc_z_test<-read.table("total_acc_z_test.txt")
# total_acc_x_train<-read.table("total_acc_x_train.txt")
# total_acc_y_train<-read.table("total_acc_y_train.txt")
# total_acc_z_train<-read.table("total_acc_z_train.txt")


library(plyr)
library(reshape2)
library(data.table)
#Create R objects of the text files we are interested in
# We are interested on the files containing the measured features:
X_test<-read.table("X_test.txt")
X_train<-read.table("X_train.txt")
# Merge both data frames together
total<-rbind(X_train, X_test)

# We are interested on the files containing the measured activities:
y_train<-read.table("y_train.txt")
y_test<-read.table("y_test.txt")
# Merge both data frames together
total_activity<-rbind(y_train, y_test)


# We are interested on the files containing info about which measurements correspond to which subject:
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")
# Merge both data frames together
total_subjects<-rbind(subject_train, subject_test)


#Add header to the total Data frame, corresponding to the features
features<-read.table("features.txt")
features<-features[,2]
names(total)<-features

#Extract only measurements containing the word mean and std
total_mean<-total[,grep("mean", names(total), value=TRUE)]
total_std<-total[,grep("std", names(total), value=TRUE)]

# Merge the extracted fata frames
total_clean<-cbind(total_mean, total_std)

#Create name of the data frame(column vector) total_activity_code in order to access it easier
names(total_activity)<-"activity"

# Change numbers by string characters specifying the activity
total_activity$activity[total_activity$activity == "1"] <- "walking"
total_activity$activity[total_activity$activity== "2"] <- "walking_upstairs"
total_activity$activity[total_activity$activity == "3"] <- "walking_downstairs"
total_activity$activity[total_activity$activity == "4"] <- "Sitting"
total_activity$activity[total_activity$activity == "5"] <- "Standing"
total_activity$activity[total_activity$activity == "6"] <- "laying"

#Add the activity column to the data frame
total_clean<-cbind(total_activity,total_clean )

#Create name to the subject data frame
names(total_subjects)<-"subject"

#Add subject column to the data frame
total_clean<-cbind(total_subjects,total_clean )

# Create new data frame from previous one, with the average of the measures for each activity and each subject
new_data_set<-aggregate(. ~subject + activity, total_clean, mean)

write.table(new_data_set, file = "tidydata.txt", row.names=FALSE, sep = "\t ", eol="\n")
