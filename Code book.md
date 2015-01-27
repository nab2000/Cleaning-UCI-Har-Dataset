
Code book for run_analysis V1.0. for use with the Human Activity Recognition Using Smartphones Dataset Version 1.0[1]
==================================================================


DataSet
=======
The original dataset and  more details describing it can be found here (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). In general, the dataset is the result of 30 different subjects performing six different activities (walking, walking up stairs, walking down stairs, sitting, standing, and laying). The data was recorded by a Samsung Galaxy S II smartphone on the subject's waist. The researchers captured x, y, and z linear acceleration and x, y, and z angular velocity from the smartphones accelrometer and gyroscope at a rate of 50 Hz.  

The data was the pre-processed with noise filters and sampled in fixed-width sliding windows of 2.56 sec and 50% overlap. A Butterworht low-pass filter was used to filter the acceleration singal into gravity and body acceleration (tBodyAcc-XYZ and tGravityAcc-XYZ). The XYZ denotes that there are X, Y, and Z components to the signal. The Jerk Signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ) were derived using the body linear acceleration and angular velocity measurements. The investigators used Euclidean norm to calculate the magnitued of the signals (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). The signals fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,fBodyAccMag fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag were produced by utilizing a Fast Fourier Transform. The t  and f denotes time and frequency signals, respectively. 

Some or all of the following functions were applied to the signals mentiotned above as well as tBodyGyro-XYZ to generate the variables in teh X_test and X_train files. The functions applied were: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between two vectors (i.e. angle(tBodyAccMean,gravity).

The dataset was broken into a training dataset and a test dataset. The folder for both the train and test datasets includes the raw, unprocessed accelerometer and gyroscope data as well as the estimated body acceleration (files in the inertial signals folder); a list of identifiers for the subject associated with the specified observation (subject_test); a list of which of the 6 activities (1 to 6) associated with the obsrvation (y_test.txt or y_train.txt); a dataset of the 561 variables for each observation that is broken into a test and training set (X_test.txt or X_train.txt). There is also a file linking each activity number to the activity name (activity_lables.txt)

The program produces two files. The first file ("tidy_HAR_Dataset.csv") is a tidy  dataset that contains only the variables that are the result of the application of the mean (Mean()) or standard deviation (std()) functions to the signals. The second fiel (tidy_HAR_Dataset_mean.txt) is a tidy dataset that takes the first tidy dataset and calculates the average of each variable for each subject under each activity condition. 

For more details see the README.md

Citation
========
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
