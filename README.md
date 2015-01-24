
run_analysis V1.0. for use with the Human Activity Recognition Using Smartphones Dataset Version 1.0[1]
==================================================================

Description
===========
This script "run_analysis.R" can be utilized to transform the raw data provided in the dataset into two tidy datasets. 

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



Application 
===========

Loading in the script loads in the necessary packages (assuming they have been isntalled with Install.packages) and sets the values for selec_col_nums. These values define the variables that will be in the final datset and can be altered if different variables are required. It then creates a number of functions that can be run in the approriate order with the "Run_tidy()" command.  This runs the following functions in this order: 

1) test_read() first creates a temp folder in the current directory that will be deleted at the end of this program. It then loads in the subject_test, X-test, and y_test files into R and then merges them together so that the new data set has the subject as the firt column, activity as the second and then the 561 measured variables. It also renames the first to column names to "Subject" and "Activity". It writes thsi data set to a file called "merged_test.csv" in the temp folder

2) train_read() is the smae as the first function except it does this for the trianing data set. It ends by creating the file "merged_train.csv"" in the temp folder

3) merge_file() this reads in the tow files created previously and merges them to each other. It then uses the values provided in selec_col_nums to extract only the specified variables(columns). As currently set up, it selects only the mean and standard deviation variables that were estimated from the many different signals. This also creates a file stored in the temp folder ("merged.csv").

4) col_rename() loads in the merged file form the temp folder and uses selec_col_nums and the "features.txt" file to change the column names for the variables from V1, V2, etc. to descriptive names (tBodyAcc-mean()-X, tBodyAcc-Std()-x, etc.). This produces a file ("newcolumns.csv") in the temp folder.

5) convert_activity() this uses the dataset with teh renamed columns and the file "activity_labels.txt"  to rename all of the numbers in the second column (Activity) to descriptive names (WALKING, WALKING_UPSTAIRS, etc.). This results int he creation of a new tidy dataset that is placed in the working directory ("tidy_HAR_Dataset.csv")

6) make_new_tidy_dataset() this uses the tidy dataset generated by convert_activity() to create another tidy dataset. This takes the data for a single subject doing a single activity and claculates teh mean for all of the variables. (e.g. for subject 1 doing the activity walking, it takes the mean of all the tBodyAcc-mean()-X measurements and the mean of all the tBodyAcc-Std()-x and the mean of all the other variables). As this is a mean, the units for each variable are not changed. This function then produces the file "tidy_HAR_Dataset_mean.txt" that is palced in the working directory.

7) end_function() deletes all the files in the temporary folder as well as the temporary folder itself. Leaving only the two tidy dataset files. 

Citation
========
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
