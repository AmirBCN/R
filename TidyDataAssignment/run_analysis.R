rm(list=ls())
setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment")
activityLabels <- read.table("activity_labels.txt")
#featuresinfo <- read.table("features_info.txt")
features <- read.table("features.txt")

##### TEST
setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment/test")
testX <- read.table("X_test.txt")
testAct <- read.table("y_test.txt")
testsubject <- read.table("subject_test.txt")

##### TRAIN
setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment/train")
trainX <- read.table("X_train.txt")
trainAct <- read.table("y_train.txt")
trainsubject <- read.table("subject_train.txt")

##### Merging Test and Train
mergedData <- rbind(testX,trainX)
mergedDataAct <- rbind(testAct,trainAct)
mergedDataSubject <- rbind(testsubject,trainsubject)

mergedDataAct <- select(merge(mergedDataAct, activityLabels), V2)

colnames(mergedDataAct) <- "Activity"
colnames(mergedDataSubject) <- "Subject"

##### Selecting Mean and Standard Deviation Values
selectmean <- features[grepl("mean", features$V2), 1]
selectSTD <- features[grepl("std", features$V2), 1]
Namemean <- as.character(features[grepl("mean", features$V2), 2])
NameSTD <- as.character(features[grepl("std", features$V2), 2])

IDmean <- paste0("V", selectmean)
IDSTD <- paste0("V", selectSTD)
selectmergedmean <- select(mergedData, IDmean)
selectmergedSTD <- select(mergedData, IDSTD )
#### Renaming variables
Namemean <- gsub('\\()','',Namemean)
NameSTD <- gsub('\\()','',NameSTD)
Namemean <- gsub('-','',Namemean)
NameSTD <- gsub('-','',NameSTD)

names(selectmergedmean) <- Namemean
names(selectmergedSTD) <- NameSTD

#### Adding activity and subject columns
Totalmerged <- cbind(mergedDataAct, mergedDataSubject, selectmergedmean, selectmergedSTD)

GroupT <- Totalmerged %>% group_by(Activity, Subject) %>% summarize(mean(tBodyAccmeanX), mean(fBodyGyrostdZ))

#Totalmerged %>% group_by(Activity, Subject) %>% mutate(Mean = mean())

#setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment/test/Inertial Signals")
#### Acc
#testBAX <- read.table("body_acc_x_test.txt")
#testBAY <- read.table("body_acc_y_test.txt")
#testBAZ <- read.table("body_acc_z_test.txt")
#### Gyro
#testBGX <- read.table("body_gyro_x_test.txt")
#testBGY <- read.table("body_gyro_y_test.txt")
#testBGZ <- read.table("body_gyro_z_test.txt")
#### Total acc
#testTAX <- read.table("total_acc_x_test.txt")
#testTAY <- read.table("total_acc_y_test.txt")
#testTAZ <- read.table("total_acc_z_test.txt")

#setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment/train")

