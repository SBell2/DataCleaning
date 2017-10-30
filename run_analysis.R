#loads packages that may be useful in analysis

library(dplyr)
library(tidyr)
library(readr)

#sets working directory to downloaded file on local drive.
#THIS WILL VARY DEPENDING ON WHERE YOUR VERSION IS SAVED

setwd("/Users/techteam/Documents/Data_Science/Getting and Cleaning Data_Final Project/UCI HAR Dataset-2")
features<-read.table("./features.txt")
train<-read.table("./train/X_train.txt")
test<-read.table("./test/X_test.txt")
subject_test<-read.table("./test/subject_test.txt")
subject_train<-read.table("./train/subject_train.txt")
activity_test<-read.table("./test/y_test.txt")
activity_train<-read.table("./train/y_train.txt")
activity_labels<-read.table("./activity_labels.txt")


#Gives names to the dataframes we will be using based on
#the README file
features<-features[,2]
names(train)<-features
names(test)<-features
names(subject_test)<-c("subject")
names(subject_train)<-c("subject")
names(activity_train)<-c("activity")
names(activity_test)<-c("activity")
names(activity_labels)<-c("activity", "activitylabel")


#brings in the subject and activity data as new columns
#for both the test and training data
train<-cbind(train,subject_train)
train<-cbind(train,activity_train)
test<-cbind(test, subject_test)
test<-cbind(test, activity_test)

#merges the test and training datasets together
merged_data<-rbind(train, test)

#segments the variables by those containing mean or standard deviation
# std() in the titles. Subject and activity are brought as well
df<-merged_data[ ,grep("mean()|std()|subject|activity", names(merged_data))]

#activity labels (which are the names of the activity numbers)
#are brought into the file
df<-merge(df, activity_labels, by.x = "activity", by.y="activity")

#names are adjusted according to: all lowercase, descriptive,
#not duplicated, and no whitespaces, '-', or other charaters

names(df)<-tolower(names(df))
names(df)<-gsub("-", "", names(df))
names(df)<-sub("^t", "time", names(df))
names(df)<-gsub("acc","accelerometer", names(df))
names(df)<-gsub("gyro", "gyroscope", names(df))
names(df)<-gsub("std()", "standarddeviation()", names(df))
names(df)<-gsub("mag", "magnitude", names(df))
names(df)<-sub("^f", "fastfouriertransform", names(df))
names(df)<-sub("freq()", "frequency()", names(df))


#creates another tidy dataset with the means of
#each variable based on activity and subject

tidy_average<-df%>%
  select(-activity)%>%
  group_by(activitylabel, subject)%>%
  summarise_each(funs(mean))

