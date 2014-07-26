## Read Data
feat <- read.table("UCI HAR Dataset/features.txt")
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")


## Extracts the feature names
featureNames <- feat[ ,2]

## change column names
colnames(trainX) <- featureNames
colnames(testX) <- featureNames
colnames(trainY) <- "activitycode"
colnames(testY) <- "activitycode"
colnames(trainSubject) <- "subject"
colnames(testSubject) <- "subject"
colnames(activityLabels) <- c("activitycode", "activity")

## merge train and test data
train <- cbind(trainSubject, trainY, trainX)
test<- cbind(testSubject, testY, testX)

## create a variable for type (train or test) and add it to the data frame
trainType <- rep("train", 7352)
train <- cbind(trainType, train)
testType <-rep("test", 2947)
test <- cbind(testType, test)
colnames(test)[1] <- "type"
colnames(train)[1] <- "type"


## Merge train and test data
data <- rbind(train, test)

## find collumns that contain Mean or st. deviation 
names <- colnames(data)
msNames <- grep(pattern ="-[Mm]ean[^a-zA-Z]|-[Ss]td[^a-zA-Z]", names)
desNames <- c(2,3, msNames)

## Extract only the measurements on the mean and standard deviation for each measurement
msdata <- data[desNames]

## add a variable for activity in descriptive 

for (i in msdata$activitycode) 
    msdata$activity[msdata$activitycode == i] <- as.character(activityLabels[i,2])

msdata$activitycode <- msdata$activity
msdata <- msdata[ ,1:68]
colnames(msdata)[2] <- "activity"

##data set with descriptive variable names
names <- colnames(msdata)
names <- gsub("Acc", " Accelometer ", names)
names <- gsub("Gyro", " Gyroscope ", names)
names <- gsub("BodyBody", "Body", names)
names <- gsub("tB", "Time B", names)
names <- gsub("tG", "Time G", names)
names <- gsub("fB", "Frequency B", names)
names <- gsub("fG", "Frequency G", names)
names <- gsub("std", "standard deviation", names)
names <- gsub("-", " ", names)
names <- gsub("\\(|\\)", " ", names)
names <- gsub("^ *|(?<= ) | *$", "", names, perl=T)
names <- gsub(" ","\\.", names)
colnames(msdata) <- names

##Create a second, independent tidy data set with the average of each variable for each activity and
##each subject.
library(plyr)
tidy <- ddply(msdata, .(subject, activity), colwise(mean))

##Create a .txt file in the working directory with the tidy data. 
write.table(tidy, "tidy.data.txt", sep="\t")
