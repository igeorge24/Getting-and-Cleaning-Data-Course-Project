## Run_analysis.R script for Getting and Cleaning Data Course Project
#
##  Reads in txt files
#
features<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt",colClasses=c("numeric","character"))
activity_labels<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",colClasses="character")
subject_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
y_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
X_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
subject_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
y_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
X_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
#
##  Combines all data tables into one table
#
test_data<-cbind(subject_test,y_test,X_test)
train_data<-cbind(subject_train,y_train,X_train)
all_data<-rbind(test_data,train_data)
#
## Change activity labels to names based on lookup table of activity names
#
activity_names<-c("1"=activity_labels[1,2],"2"=activity_labels[2,2],"3"=activity_labels[3,2],"4"=activity_labels[4,2],"5"=activity_labels[5,2],"6"=activity_labels[6,2])
all_data[,2]<-activity_names[all_data[,2]]
#
## Change column names to correct variable names
#
colnames(all_data)<-c("Subject_ID","Activity",features[,2])
#
## Subset mean and std columns from all_data
#
x<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516:517,526,529:530,539,542:543,552,555:561)
col_indices<-c(1,2,x+2)
sub_data<-all_data[,col_indices]
sub_data<-sub_data[order(sub_data$Subject_ID,sub_data$Activity),]
#  
##   Creates tidy data table summarizing mean values for each measurement by subject and activity
#
library(dplyr)
groups<-group_by(sub_data,Subject_ID,Activity)
averaged_data<-summarise_each(groups,funs(mean),3:88)
write.table(averaged_data,file="tidy_data.txt",row.name=FALSE)


