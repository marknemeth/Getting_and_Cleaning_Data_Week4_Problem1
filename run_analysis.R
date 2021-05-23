####################################################################################################################
################################################## Assignment 4: Problem 1 #########################################
####################################################################################################################

########################################### Capture dataset for use in Problem #####################################

if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/getdata_projectfiles_UCI_HAR_Dataset.zip",method="curl")

unzip(zipfile="./data/getdata_projectfiles_UCI_HAR_Dataset.zip",
      files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = "./data", unzip = "internal",
      setTimes = FALSE)

#Files are now in "./data/UCI HAR Dataset"

########################################### Process features and subjects files ####################################

activity_labels<-read.table(file="./data/UCI HAR Dataset/activity_labels.txt", header=FALSE, sep=" ",
                            skip=0, stringsAsFactors = FALSE, col.names = c("activityID","activity"))
features<-read.table(file="./data/UCI HAR Dataset/features.txt", header=FALSE, sep=" ",
                            skip=0, stringsAsFactors = FALSE, col.names = c("featureID","feature"))

####################################################################################################################
#Test data - rowIDs connect subjects to their activities in the x and y text files; activity labels connect by rowID, too.
####################################################################################################################
activityIDs_test<-read.table(file="./data/UCI HAR Dataset/test/y_test.txt", header=FALSE, sep=" ",
                     skip=0, stringsAsFactors = FALSE, col.names = c("activityID"))

subjectIDs_test<-read.table(file="./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep=" ",
                             skip=0, stringsAsFactors = FALSE, col.names = c("subjectID"))

#Must pull in X file and recreate as csv file
con<-file("./data/UCI HAR Dataset/test/X_test.txt"); open(con,"r");x<-readLines(con);close(con)

cleanSpaces1<-function(x){gsub(" -", ",-",x)}
x<-sapply(x,cleanSpaces1)
cleanSpaces2<-function(x){gsub("  ", ",",x)}
x<-sapply(x,cleanSpaces2)
cleanSpaces3<-function(x){gsub("^,", "",x)}
x<-sapply(x,cleanSpaces3)

writeLines(x,"./data/UCI HAR Dataset/test/X_test.csv")
data_test<-read.csv(file="./data/UCI HAR Dataset/test/X_test.csv", header=FALSE, dec=".")
colnames(data_test)<-features[["feature"]]
        
####################################################################################################################
#Train data - rowIDs connect subjects to their activities in the x and y text files; activity labels connect by rowID, too.
####################################################################################################################
activityIDs_train<-read.table(file="./data/UCI HAR Dataset/train/y_train.txt", header=FALSE, sep=" ",
                             skip=0, stringsAsFactors = FALSE, col.names = c("activityID"))

subjectIDs_train<-read.table(file="./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep=" ",
                            skip=0, stringsAsFactors = FALSE, col.names = c("subjectID"))

#Must pull in X file and recreate as csv file
con<-file("./data/UCI HAR Dataset/train/X_train.txt"); open(con,"r");x<-readLines(con);close(con)

cleanSpaces1<-function(x){gsub(" -", ",-",x)}
x<-sapply(x,cleanSpaces1)
cleanSpaces2<-function(x){gsub("  ", ",",x)}
x<-sapply(x,cleanSpaces2)
cleanSpaces3<-function(x){gsub("^,", "",x)}
x<-sapply(x,cleanSpaces3)

writeLines(x,"./data/UCI HAR Dataset/train/X_train.csv")
data_train<-read.csv(file="./data/UCI HAR Dataset/train/X_train.csv", header=FALSE, dec=".")
colnames(data_train)=features[["feature"]]

rm(x)

####################################################################################################################
#All database files are in the R environment now.
####################################################################################################################

###############################################Align Subject IDs with Test/Train runs###############################

data_test<-cbind(subjectIDs_test,data_test)
data_train<-cbind(subjectIDs_train, data_train)

###############################################Align Activity IDs with Test/Train runs###############################

data_test<-cbind(activityIDs_test,data_test)
data_train<-cbind(activityIDs_train, data_train)

###############################################Merge Activity Labels with Test/Train runs (right outer joins)########

data_test<-merge(activity_labels, data_test, by.x="activityID", by.y="activityID", all.y=TRUE)
data_train<-merge(activity_labels, data_train, by.x="activityID", by.y="activityID", all.y=TRUE)

############################################### Now, stack the test and train data, as required for exercise ########

data_all<-rbind(data_test,data_train) # 2947 + 7352 = 10,299

############################################### Last step prior to rolling up in means of each variable #############
############################################### Limit measurement variables to only those on mean() and std() #######
###################################### Note that the angle measurements at 555-561 are tertiary mse's on means ######
###################################### as are the "meanFreq" mse's ##################################################

cleanVarnames<-function(x){grep("(.*Mean|-mean|-std)",x, value=TRUE)}
keeps<-sapply(features[["feature"]],cleanVarnames)
keeps
length(keeps[keeps[]!="character(0)"])

#86 measures (tested in MS Access, too.) Then Subject and Activity = 88 total columns at end.

drops<-keeps[keeps[]=="character(0)"]
drops<-names(drops) #(475 = 561 - 86)
drops
keeps<-(keeps[keeps[]!="character(0)"])
keeps<-names(keeps)
keeps<-append(c("activity", "subjectID"),keeps) #Could keep activityID in front, too, but activity is suff.
keeps # these are all the needed columns of measure and for final grouping

###################################### Final raw dataset before producing tidy dataset ##############################
data_all <- data_all[,(names(data_all) %in% keeps)]
names(data_all)
str(data_all)

#This was added after initial pass at data.
#This brings in more descriptive variable names
#for our work here.  The accompanying Codebook
#document provides the mapping and reasoning.
features_tidy<-read.csv(file="Codebook_VarLists_Import.csv", header=TRUE, sep="|")
colnames(data_all)=features_tidy[["TidySet.VarNames"]]
names(data_all)
str(data_all)
###################################### Final raw dataset before producing tidy dataset ##############################

#Summarize the dataset before producing final tidy dataset
summary(data_all)
#Subject IDs are from 1 to 30 for the 30 subjects in the study
#Activity count is 10,299 for the total number of records
#Activity IDs range from 1 to 6 as expected from activity dictionary:
#       1 WALKING
#       2 WALKING_UPSTAIRS
#       3 WALKING_DOWNSTAIRS
#       4 SITTING
#       5 STANDING
#       6 LAYING

library(dplyr)
data_all<-group_by(data_all,activity,subjectID)
tidyset_wNA<-summarise_all(data_all,mean, na.rm=TRUE)
tidyset_noNA<-summarise_all(data_all,mean)

write.csv(tidyset_wNA,"./data/UCI HAR Dataset/tidyset_with_NAs.csv")
write.csv(tidyset_noNA,"./data/UCI HAR Dataset/tidyset_without_NAs.csv")

tidyset_wNA
tidyset_noNA

write.csv(summary(tidyset_wNA),"./data/UCI HAR Dataset/summary_tidyset_with_NAs_allowed.csv")
write.csv(summary(tidyset_noNA),"./data/UCI HAR Dataset/summary_tidyset_without_NAs_allowed.csv")
write.csv(summary(as.factor(tidyset_noNA["activity"])),"./data/UCI HAR Dataset/summary_tidyset_activityConfirm.csv")

#There are no missed observations in the overall raw data, so tidyset_wNA = tidyset_noNA; hence, we output df named only tidyset.
tidyset<-tidyset_noNA
write.csv(tidyset,"./data/UCI HAR Dataset/tidyset.csv")
write.csv(summary(tidyset),"./data/UCI HAR Dataset/summary_tidyset.csv")
write.csv(summary(as.factor(tidyset["activity"])),"./data/UCI HAR Dataset/summary_tidyset_activityConfirm.csv")
