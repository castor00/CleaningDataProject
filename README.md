
Getting and Cleaning Data Course Project Script explanation
========================================================

The repo includes the folowing files
- run_analysis.R : The script eith the r code to complete the project
- tidy.data.txt : The tidy data set that is the result of the analysis
- CodeBook.md: Explaines the variable od the tidy data set
- README.md: Describes the analysis performed to reach the tidy data set. 

This document accompanies the the "run_analysis.R" file and explains the code used to complete the course project of Getting and cleaning data. 

## Step 1: Merge the training and the test sets to create one data set

The code starts by loading the data to the environment. Note that the data should be unzipped within the working directory, witch means that you should have in your working directory a folder named "UCI HAR Dataset" that contains the "test" and "train" folders and the files: "features_info.txt", "features.txt" and "activity_labels.txt". 

The following expressions read the required data. 
```{r}
feat <- read.table("UCI HAR Dataset/features.txt")  
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")  
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
```

After running the previous expressions we end up with the following data in our environment:

- feat: a data frame with 561 obs of 2 variables. V1 an integer from 1 to 561, V2 a factor of 561 levels that contains the feature names. 
- trainX: a data frame with 7352 obs. of 561 variables. All numeric. Contains the train data set. 
- trainY: a data frame with 7352 obs. of 1 variable. Contains the training labels of the train data set. Integer between 1 and 6
- trainSubject: a data frame with 7352 obs. of 1 variable. Contains the subject who performed the activity of the train data set. Integer between 1 and 30
- activityLabels: a data frame with 6 obs. of 2 variables. V1 an integer from 1to 6, V2 a factor with 6 levels. Links the training labels of "trainY"" with their activity name.
- testX: a data frame with 2947 obs. of 561 variables. All numeric. Contains the test data set.
- testY: a data frame with 2947 obs. of 1 variable. Contains the training labels of the train data set. Integer between 1 and 6
- testSubject: a data frame with 2947 obs. of 1 variable. Contains the subject who performed the activity of the test data set. Integer between 1 and 30

The following functions appropriately name the variables of each data set. 
The "trainX" and "testX" data sets take their names from the second variable of "feat". 
```{r}
featureNames <- feat[ ,2]
colnames(trainX) <- featureNames
colnames(testX) <- featureNames
```

I also name the "trainY" and "testY" variable as "activiycode", the "trainSubject" and "testSubject" variable as "subject" and the "activityLabels" two variables as "activitycode" and "activity", respectively. 
```{r}
colnames(trainY) <- "activitycode"
colnames(testY) <- "activitycode"
colnames(trainSubject) <- "subject"
colnames(testSubject) <- "subject"
colnames(activityLabels) <- c("activitycode", "activity")
```
Next, I merge the "trainSubject", "trainY" and "trainX" datasets into a data set named "train" and the "testSubject", "testY" and "testX" into the "test" data set, using the cbind() function.
```{r}
train <- cbind(trainSubject, trainY, trainX)
test<- cbind(testSubject, testY, testX)
```
The result is two data frames. One with the train data, which consists of 7352 obs. of 563 variables and one with the test data, which consists of 2947 obs. of 563 variables.
The 563 variables are the "subject", the activity label and the 561 features. 

Next, I create 2 variables that contain the word train for the train data set and the word test for the test data set and I merge them with the respective data set. This is done in order to be able to distinguish if the observation is from the train data set or the test data set. I name this variable "type".

```{r}
trainType <- rep("train", 7352)
train <- cbind(trainType, train)
testType <-rep("test", 2947)
test <- cbind(testType, test)
colnames(test)[1] <- "type"
colnames(train)[1] <- "type"
```
To complete the 1 step of the instructions I just have to merge the "train" and "test" data sets, using the rbind function. 
```{r}
data <- rbind(train, test)
```
The result is a data frame of 10299 obs. of 564 variables. The first variable is a factor with 2 levels (train, test), the second is the subject (integer 1:30) and the third is the activity label (integer 1:6). The next 561 variables are the features.  

## Step 2: Extract only the measurements on the mean and standard deviation for each measurement

In these step I use regular expressions in order to select the variables that are mean or standard deviation of the measurements. 
First, I extract the names of the data set, making a character string with all the variable names of the data. 
```{r}
names <- colnames(data)
```
To select the desired variables i use the expression: 
```{r}
msNames <- grep(pattern ="-[Mm]ean[^a-zA-Z]|-[Ss]td[^a-zA-Z]", names)
```
Which returns the number of the columns that have the string "-mean" or "-std", either starting with the capital letter (M or S) or lowercase (m or s) and it is not followed by a letter. I use the "-" before the string in order no to select variables like "angle(tBodyGyroMean,gravityMean)" which is the Angle between two vectors and not the mean of a measurement. I also use "[^a-zA-Z]" that means "it is not followed by any letter" in order not to select variables like "fBodyBodyAccJerkMag-meanFreq()" which is a mean frequency and not a mean of a measurement, because the mean measurement is "fBodyBodyGyroJerkMag-mean()"

Next I add the columns 2 and 3 which are the object and the activity Label and I subset the data keeping only the desired variables.     
```{r}
desNames <- c(2,3, msNames)
msdata <- data[desNames]
```
The result is a data frame of 10299 obs. of 68 variables. The first variable is the subject (integer 1:30) and the second is the activity label (integer 1:6). The next 66 variables are the measurement that are the mean or the standard deviation of all the measurements.  

## Step 3: Use descriptive activity names to name the activities in the data set

In this step it is requested to change the activity label variable with the respective activities. 

To do this I use the for: 
```{r}
for (i in msdata$activitycode) 
    msdata$activity[msdata$activitycode == i] <- as.character(activityLabels[i,2])
```
The expression above adds another variable that i call "activity" with the descriptive activity names. Then, I move the new variable "activity" in the place of the variable "activitycode", which is the activity labels, drop the "activity" and rename the variable "activitycode" into "activity". 
```{r}
msdata$activitycode <- msdata$activity
msdata <- msdata[ ,1:68]
colnames(msdata)[2] <- "activity"
```
The result is the same as the previous step but using descriptive activity names instead of the activity labels. 

## Step 4: Appropriately label the data set with descriptive variable names

This step requires to change the names of the variables into descriptive. 

First, I extract the names of the variable in a new character string.

```{r}
names <- colnames(msdata)
```
Then, I make the the changes by using the gsub function. I replace the abbreviations with the complete names.
```{r}
names <- gsub("Acc", " Accelometer ", names)
names <- gsub("Gyro", " Gyroscope ", names)
names <- gsub("BodyBody", "Body", names)
names <- gsub("tB", "Time B", names)
names <- gsub("tG", "Time G", names)
names <- gsub("fB", "Frequency B", names)
names <- gsub("fG", "Frequency G", names)
names <- gsub("std", "standard deviation", names)
```
Consequently, I remove the dashes and the brackets, replacing them with spaces.
```{r}
names <- gsub("-", " ", names)
names <- gsub("\\(|\\)", " ", names)
```
Because of the multiple spaces that have been introduced i use the following expression to remove them and keep single spaces between the words. The following expressions finds multiple spaces at the start of the text string or in the middle or at the end and replaces them with nothig. 
```{r}
names <- gsub("^ *|(?<= ) | *$", "", names, perl=T)
```
Next, I substitute the spaces with dots and re-name the variables in the data set. 
```{r}
names <- gsub(" ","\\.", names)
colnames(msdata) <- names
```

## Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.

This step requires to create a new tidy data that are the average of the variables for each activity and subject. 

For this step I used the ddply function from the plyr package. 

```{r}
library(plyr)
tidy <- ddply(msdata, .(subject, activity), colwise(mean))
```
The result is a data frame consisting of 180 observations  (30 subjects*6 activities) of 68 variables. The first variable is the subject and the second is the activity. The next 66 variables are the meansper subject and activiy of mean and standard deviation of all measurements.  

Finally, I write the tidy data in a .txt file. 
```{r}
write.table(tidy, "tidy.data.txt", sep="\t")
```

I believe that the data are consistent with the 3 rules of the tidy data. 
- Each variable in one column
- Each observation in a different row
- One table for each kind variable

The variables of the data set are described at the CodeBook.md