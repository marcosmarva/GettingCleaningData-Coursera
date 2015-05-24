# Clean all variables
rm(list=ls())


# Set working directory
setwd("~/Documentos/Master/courses-master/03_GettingData/project")

# Read and gather test data
subjectTest <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
dataTest <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
dfTest = data.frame(subjectTest, activityTest, dataTest)

# Read and gather training data
subjectTrain <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
dataTrain <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
dfTrain = data.frame(subjectTrain, activityTrain, dataTrain)

###########################################################################################
#### 1.- Merges the training and the test sets to create one data set.
###########################################################################################
df <- rbind(dfTest, dfTrain)

###########################################################################################
### 2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
###########################################################################################
# get a table displaying the all the features
AllFeatures <- read.table(file = "UCI HAR Dataset/features.txt")

# select the measurements on the mean and standard deviation for each measurement. 
myFeatures <- which(grepl("mean|std", x = as.character(AllFeatures$V2)))

# get the dataframe with the desired columns
myDataFrame <- df[, c(1, 2, myFeatures)]

###########################################################################################
### 3.- Uses descriptive activity names to name the activities in the data set
###########################################################################################
# get the activity labels 
allActivities <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
activityName = as.character(allActivities$V2)

# in the raw data the activity is coded with a number and this column is numeric. 
# First convert this column in a factor
myDataFrame[ ,2] <- factor(myDataFrame[ ,2])

# and then relabel the levels of the factor
levels(myDataFrame[ ,2])<-activityName

###########################################################################################
#### 4.- Appropriately labels the data set with descriptive variable names. 
###########################################################################################
# chose the right labelsfor the selected features
measuramentNames <- as.character(AllFeatures[myFeatures, 2])

# set the column names
myNames<- c("Subject", "Activity", measuramentNames)
colnames(myDataFrame) <- myNames

###########################################################################################
##### 5.- From the data set in step 4, creates a second, independent tidy data set with 
##### the average of each variable for each activity and each subject
###########################################################################################
write.table(myDataFrame, file = "./tidyData.txt", row.names = FALSE)
