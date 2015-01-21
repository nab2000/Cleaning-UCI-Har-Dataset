## To utilize this file just load it in then use the run_tidy() 
## call to run the function

## laods in necessary packages
library (data.table)
library (reshape2)

## provides the list of columns to obtained from 
## xtrain and x test. Modify if need different values
selec_col_nums <-  c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 
                     121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 
                     202, 214, 215, 227, 228, 240, 241, 253, 254, 
                     266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427,
                     428, 429, 503, 504, 542, 543)



## reads in training data set and combines subject and activity info
## result is one  file stored in the temporary folder

train_read <- function() {
        print("Getting and merging training data...")
        if(!file.exists("./temp")) {dir.create("./temp")}
        
        xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
        ytrain <- fread("./UCI HAR Dataset/train/y_train.txt")
        xtrainDT <- as.data.table(xtrain)
        subtrain <- fread("./UCI HAR Dataset/train/subject_train.txt")
        setnames(ytrain, "V1", "Activity")
        setnames(subtrain, "V1", "Subject")
        mergetrain <- cbind(subtrain, ytrain, xtrainDT)
        
        print("files merged, writing file...")
        if (!file.exists("./temp/merged_train.csv")){
                file.create("./temp/merged_train.csv")
        }
        
        write.csv(mergetrain, "./temp/merged_train.csv", row.names =F)
}

## read in the testing data set and append activity and subject
## information
test_read <- function() {
        print("Getting and merging test data...")
        if(!file.exists("./temp")) {dir.create("./temp")}
        
        xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
        ytest <- fread("./UCI HAR Dataset/test/y_test.txt")
        xtestDT <- as.data.table(xtest)
        subtest <- fread("./UCI HAR Dataset/test/subject_test.txt")
        setnames(ytest, "V1", "Activity")
        setnames(subtest, "V1", "Subject")
        mergetest <- cbind(subtest, ytest, xtestDT)
       
        print("files merged, writing file...")
        if (!file.exists("./temp/merged_test.csv")){
                file.create("./temp/merged_test.csv")
        }
        
        write.csv(mergetest, "./temp/merged_test.csv", row.names =F)
}


## merge files and selects only the mean and standard deviation 
##columns and the subject and activity columns

merge_file <- function() {
        ## merges two files
        print("merging test and training files...")
        test <- fread("./temp/merged_test.csv")
        train <- fread("./temp/merged_train.csv")
        complete <- rbind(test, train)
        compDF <- as.data.frame(complete)

        ## uses selec_col_nums to subset out specified variables
        print("Done merging. Subsetting data...")
        col_call <- NULL
        for(i in selec_col_nums) {
                V <- "V"
                temp <- paste(V, i, sep= "")
                col_call <- c(col_call, temp)
        }   
        
        columns <- c("Subject", "Activity", col_call )
        subst <- compDF[,columns]

        print("files merged, writing file...")
        if (!file.exists("./temp/merged.csv")){
                file.create("./temp/merged.csv")
        }
        write.csv(subst, "./temp/merged.csv", row.names =F)
}

## This function renames the columns using descriptive names 
## provided in features.txt file
col_rename <- function() {
        print ("getting files and renaming columns...")
        file <- fread("./temp/merged.csv")
        fileDF <- as.data.frame(file)
        titles <- read.table("./UCI HAR Dataset/features.txt")
        names_list <- titles[,2]
        new_col_names <- names_list[selec_col_nums]
        column_values <- as.character(new_col_names)
        colnames(fileDF) <- c("subject", "activity", column_values)
        
        print("Columns renamed, writing file...")
        if (!file.exists("./temp/newcolumns.csv")){
                file.create("./temp/newcolumns.csv")
        }
        write.csv(fileDF, "./temp/newcolumns.csv", row.names =F)
}


## make functions that read through number and gives value for that number as list then use that to replace column.
## list of all the columns in the xtrain/test data sets that 
## you want to incorporate into tidy data
convert_activity <- function() {
        print("Getting files and preparing activity descriptions...")
        file <- fread("./temp/newcolumns.csv")
        tempfile <- file$activity
        dict <- fread("./UCI HAR Dataset/activity_labels.txt")
        
        activity_list = NULL
        for (i in tempfile){
                temp <- dict[i, V2]
                activity_list <- c(activity_list, temp)
        }
        file$activity <- activity_list
        
        print("Activity descriptions applied, writing file...")
        if (!file.exists("./tidy_HAR_Dataset.csv")){
                file.create("./tidy_HAR_Dataset.csv")
        }
        write.csv(file, "./tidy_HAR_Dataset.csv", row.names =F)
        
}

## this takes the first tidy dataset and makes a second tidy datset
##where the mean is taken for every variable for each unique 
##subject+activity combination (i.e. subject 1 walking, 
##subject 1 sitting, etc)
make_new_tidy_dataset <- function(){
        print("Loading in first tidy dataset and making second...")
        
        temp <- fread("./tidy_HAR_Dataset.csv")
        meltfile <- melt(temp, id = c("subject", "activity"))
        castfile <- dcast(meltfile, subject + activity ~variable, mean)

        print("Second tidy dataset created. writing file...")
        if (!file.exists("./tidy_HAR_Dataset_mean.txt")){
                file.create("./tidy_HAR_Dataset_mean.txt")
        }
        write.table(castfile, "./tidy_HAR_Dataset_mean.txt", row.names =F)
}

end_function <- function(){
        unlink("./temp", recursive = T)
}
        
## run functions in the approraite orders
Run_Tidy <- function(){
        test_read()
        train_read()
        merge_file()
        col_rename()
        convert_activity()
        make_new_tidy_dataset()
        end_function()
}
