Getting and Cleaning Data Course Project Code Book
========================================================

This document accompanies the the tidy.data.txt file that was submitted and explains the code used to complete the course project of Getting and cleaning data. 

The data set is a clean and tidy data set of Human Activity Recognition Using Smartphones Dataset. 

The transformations that were implemented (and it is described in detail in README.md file) were: 
- to appropriately name the variables of the data set. 
- merge the test subject, test activity label and test feature measurement to the test data
- merge the train subject, train activity label and train feature measurement to the train data
- merge the test and train data
- Subset the data by keeping the variables that are measurements on the mean and standard deviation for each measurement
- Use descriptive activity names instead of activity labels
- Change the variable names into descriptive ones
- Create a data set with the  average of each variable for each activity and each subject

The data set consist of  observations of  variables. The first  variables are: 
- subject: is the subject that performed the activity. There are  subjects. 
- activity: the activity that were performed by the subject. There are  activities
  - WALKING
  - WALKING UPSTAIRS
  - WALKING DOWNSTAIRS
  - SITTING
  - STANDING
  - LAYING

The rest  variables are the means per subject and activity of the mean and standard deviations of the following measurements. 

Time.Body.Accelometer.mean.X
Time.Body.Accelometer.mean.Y
Time.Body.Accelometer.mean.Z
Time.Body.Accelometer.standard.deviation.Y
Time.Body.Accelometer.standard.deviation.Z
Time.Gravity.Accelometer.mean.X
Time.Gravity.Accelometer.mean.Y
Time.Gravity.Accelometer.mean.Z
Time.Gravity.Accelometer.standard.deviation.X
Time.Gravity.Accelometer.standard.deviation.Y
Time.Gravity.Accelometer.standard.deviation.Z
Time.Body.Accelometer.Jerk.mean.X
Time.Body.Accelometer.Jerk.mean.Y
Time.Body.Accelometer.Jerk.mean.Z
Time.Body.Accelometer.Jerk.standard.deviation.X
Time.Body.Accelometer.Jerk.standard.deviation.Y
Time.Body.Accelometer.Jerk.standard.deviation.Z
Time.Body.Gyroscope.mean.X
Time.Body.Gyroscope.mean.Y
Time.Body.Gyroscope.mean.Z
Time.Body.Gyroscope.standard.deviation.X
Time.Body.Gyroscope.standard.deviation.Y
Time.Body.Gyroscope.standard.deviation.Z
Time.Body.Gyroscope.Jerk.mean.X
Time.Body.Gyroscope.Jerk.mean.Y
Time.Body.Gyroscope.Jerk.mean.Z
Time.Body.Gyroscope.Jerk.standard.deviation.X
Time.Body.Gyroscope.Jerk.standard.deviation.Y
Time.Body.Gyroscope.Jerk.standard.deviation.Z
Time.Body.Accelometer.Mag.mean
Time.Body.Accelometer.Mag.standard.deviation
Time.Gravity.Accelometer.Mag.mean
Time.Gravity.Accelometer.Mag.standard.deviation
Time.Body.Accelometer.JerkMag.mean
Time.Body.Accelometer.JerkMag.standard.deviation
Time.Body.Gyroscope.Mag.mean
Time.Body.Gyroscope.Mag.standard.deviation
Time.Body.Gyroscope.JerkMag.mean
Time.Body.Gyroscope.JerkMag.standard.deviation
Frequency.Body.Accelometer.mean.X
Frequency.Body.Accelometer.mean.Y
Frequency.Body.Accelometer.mean.Z
Frequency.Body.Accelometer.standard.deviation.X
Frequency.Body.Accelometer.standard.deviation.Y
Frequency.Body.Accelometer.standard.deviation.Z
Frequency.Body.Accelometer.Jerk.mean.X
Frequency.Body.Accelometer.Jerk.mean.Y
Frequency.Body.Accelometer.Jerk.mean.Z
Frequency.Body.Accelometer.Jerk.standard.deviation.X
Frequency.Body.Accelometer.Jerk.standard.deviation.Y
Frequency.Body.Accelometer.Jerk.standard.deviation.Z
Frequency.Body.Gyroscope.mean.X
Frequency.Body.Gyroscope.mean.Y
Frequency.Body.Gyroscope.mean.Z
Frequency.Body.Gyroscope.standard.deviation.X
Frequency.Body.Gyroscope.standard.deviation.Y
Frequency.Body.Gyroscope.standard.deviation.Z
Frequency.Body.Accelometer.Mag.mean
Frequency.Body.Accelometer.Mag.standard.deviation
Frequency.Body.Accelometer.JerkMag.mean
Frequency.Body.Accelometer.JerkMag.standard.deviation
Frequency.Body.Gyroscope.Mag.mean
Frequency.Body.Gyroscope.Mag.standard.deviation
Frequency.Body.Gyroscope.JerkMag.mean
Frequency.Body.Gyroscope.JerkMag.standard.deviation

I am not able to fully understand what each variable is, so i append the explanation of the original data. 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals Time.Acceelometer-XYZ and Time.Gyroscope.XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (Time.Body.Accelometer.XYZ and Time.Gravity.Accelometer.XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (Time.Body.Accelometer.Jerk.XYZ and Time.Body.Gyroscope.Jerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (Time.Body.Accelometer.Mag, Time.Gravity.Accelometer.Mag, Time.Body.Accelometer.JerkMag, Time.Body.Gyroscope.Mag, Time.Body.Gyroscope.JerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing Frequency.Body.Accelometer.XYZ, Frequency.Body.Accelometer.Jerk.XYZ, Frequency.Body.Gyroscope.XYZ, Frequency.Body.Accelometer.JerkMag, Frequency.Body.Gyroscope.Mag, Frequency.Body.Gyroscope.JerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.