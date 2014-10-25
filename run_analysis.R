run_analysis <- function() {
  
  filePath <- function(...) { paste(..., sep = "/") }
#   require(plyr)
  
  # Set working dir
#   setwd("~/Classes/Getting and Cleaning Data/Project")
  print(getwd())
  
  #---------------------------------------------#
  # Step 0 - Download and Read data into tables #
  #---------------------------------------------#
  
  # Note: Following are the checks -
  # Check if data directory exists, if not create it
  # Check if zip file has been downloaded, if not download it
  # Check if unzip is already done, if not unzip the file.
  # Above checks are done to remove unnecessary downloads and unzipping.

  # set data directory
  dataDir <- "data"
  dataPath <- filePath(getwd(), dataDir)
  if(!file.exists(dataPath)) {
    dir.create(dataPath, showWarnings = TRUE, recursive = FALSE, mode = "0777")
    cat("Directory created:", dataPath)
  }
  
  # Check if data is already loaded & unzipped.
  # if not load and/or unzip
  zipName <- filePath(dataDir,"dataset.zip")
  if(!file.exists(zipName)) { 
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, zipName)
  }
  
  unzipDir <- filePath(dataDir,"UCI HAR Dataset")
  if(!file.exists(unzipDir)) { 
    unzip(zipName, exdir = dataDir)
    
  } 
  
  # NOTE:
  # The tables are always reloaded because following joins and manipulations may have updated them.

  # Read train data into tables
  X_trainData <- read.table(filePath(unzipDir, "train/X_train.txt")) # dim 7352  561
  y_trainData <- read.table(filePath(unzipDir, "train/Y_train.txt")) # dim 7352    1
  sub_trainData <- read.table(filePath(unzipDir, "train/subject_train.txt")) # dim 7352    1
  
  # Read test data into tables
  X_testData <- read.table(filePath(unzipDir, "test/X_test.txt")) # dim 2947  561
  y_testData <- read.table(filePath(unzipDir, "test/y_test.txt")) # dim 2947    1
  sub_testData <- read.table(filePath(unzipDir,"test/subject_test.txt")) # dim 2947    1
  
  # Read Feature and activity files
  features <- read.table(filePath(unzipDir,"features.txt")) # dim 561   2
  activity <- read.table(filePath(unzipDir,"activity_labels.txt")) # dim 6  2
  
  #-----------------------------------------------------------------#
  # Step 1                                                          #
  # 1 - Merge the training and the test sets to create one data set.#
  #-----------------------------------------------------------------#
  
  # Join train & test data corresponding tables
  x_joinData <- rbind(X_trainData, X_testData) # dim 10299 561
  y_joinData <- rbind(y_trainData, y_testData) # dim 10299 1
  sub_joinData <- rbind(sub_trainData, sub_testData) # dim 10299 1
  
  #--------------------------------------------------------------------------------------------#
  # Step 2                                                                                     #
  # 2 - Extracts only the measurements on the mean and standard deviation for each measurement.#
  #--------------------------------------------------------------------------------------------#
  
  meanStdIndices <- grep("(mean|std)\\(\\)", features[, 2]) #length(meanStdIndices) 66
  x_joinData <- x_joinData[, meanStdIndices] #dim(x_joinData) # 10299   66
  
  names(x_joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
  names(x_joinData) <- gsub("-", "", names(x_joinData)) # remove "-" in column names 
  names(x_joinData) <- gsub("^t", "time", names(x_joinData)) # Changed ^t to time
  names(x_joinData) <- gsub("^f", "freq", names(x_joinData)) # Changed ^f to freq

  #-----------------------------------------------------------------------------#
  # Step 3                                                                      #
  # 3 - Uses descriptive activity names to name the activities in the data set. #
  #-----------------------------------------------------------------------------#
  
  activityLabel <- activity[y_joinData[, 1], 2]
  y_joinData[, 1] <- activityLabel
  names(y_joinData) <- "Activity"
  
  #-----------------------------------------------------------------------#
  # Step 4                                                                #
  # 4 - Appropriately labels the data set with descriptive activity names.#
  #-----------------------------------------------------------------------#
  
  names(sub_joinData) <- "Subject"
  
  #-----------------------------------------------------------------------------------#
  # Step5.                                                                            #
  # 5 - From the data set in step 4, Creates a second, independent tidy data set with # 
  # the average of each variable for each activity and each subject.                  #
  #-----------------------------------------------------------------------------------#
  # Note: Final tidyData should be 30 subjects * 6 activities (180 rows) with 68 columns
  
  cleanedData <- cbind(sub_joinData, y_joinData, x_joinData) #dim 10299 68
#   write.table(cleanedData, "cleanedData.txt") # write out the 1st dataset for debug
   
#   tidy = ddply(cleanedData, c("Subject","Activity"), numcolwise(mean)) # Works, needs lib plyr
  tidy = aggregate.data.frame(x = x_joinData, by = cbind(y_joinData, sub_joinData), FUN = mean)
  tidy <- tidy[c("Subject", setdiff(names(tidy), "Subject"))]
  
  write.table(tidy, "tidyData.txt") # Final dataset to submit for project
  
#   Instruction to read the data back in from file
#   tidyData <- read.table("tidyData.txt", sep=" ", header=TRUE)
#   print( "Tidy Data")
#   dim(tidyData) 
#   head(tidyData)
  
}

