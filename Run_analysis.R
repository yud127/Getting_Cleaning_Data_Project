##********** 1. Set the working directory***********

setwd("my computer path/Project")
library(data.table)
library(plyr)
library(dplyr)

##********** 2.a download files***********
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./project.zip", method= "curl")

##********** 2.b check if file exists***********
list.files("./")

##********** 2.c unzip the file***********
unzip(zipfile="./project.zip",exdir="./")

##*********3.a read files**********
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
Subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
Subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<- read.table("./UCI HAR Dataset/features.txt")

#********3.b rename variables***********
colnames(X_train) <- features[,2]
colnames(X_test) <- features[,2]
names(Y_test)<-c("activitylabel")
names(Y_train)<-c("activitylabel")
names(Subject_test)<-c("subjectID")
names(Subject_train)<-("subjectID")


##********4 .Merge two data set together**********
data_test<-cbind(X_test,Y_test,Subject_test)
data_train<-cbind(X_train,Y_train, Subject_train)
data_merge<-rbind(data_test,data_train)
dim(data_merge) ### 10299, 563

##*********5. Extracts only the measurements on the mean and standard deviation for each measurement.**********

data_extract<-data_merge[ , grepl( "mean" , names( data_merge ) ) ,grepl( "std" , names( data_merge ) )]
data_id<-data_merge[ , grepl( "activitylabel" , names( data_merge ) )]
## ? tried to grepl activitylabel and subjectID together but didnt work. 
data_subject<-data_merge[ ,grepl( "subjectID" , names( data_merge ) )]
data_new<-cbind(data_extract,data_id,data_subject)
names(data_new)
names(data_new)[47]<-"activitylabel"
names(data_new)[48]<-"subjectID"

##tried this code but didnt work
#data_id<-data_merge %>% select("activitylabel" ,"subjectID")
#Error: Can't bind data because some arguments have the same name


##*********6 .name the activities in the data set***********
data_new$activitylabel <- activity_labels[data_new$activitylabel, 2]

# alternative way
#data_new$activitylabel<- merge(data_new, activity_labels, by='activitylabel')
#data_new$activitylabel <- recode(data_new$activitylabel, c("1"="WALKING","2"="WALKING_UPSTAIRS",3="WALKING_DOWNSTAIRS",4="SITTING",5="STANDING",6="LAYING"))

##**********7. labels the data set with descriptive variable names.*******
names(data_new)
#colnames(data_new)<-gsub("()-X", "-X", colnames(data_new)) # no effect?
#colnames(data_new)<-gsub("-mean()-", "mean", colnames(data_new)) # no effect?
colnames(data_new)<-gsub("-mean", ".mean", colnames(data_new)) # this works
colnames(data_new)<-gsub("BodyBody", "Body", colnames(data_new))


### can't remove ()?

#******************8. create an tidy dataset*******
data_final<- data_new %>%
            group_by(subjectID, activitylabel) %>%
            summarise_all(list(mean=mean))
write.table(data_final, "Final.txt", row.name=FALSE)