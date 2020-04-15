############### Merge the training and test sets to create one data set ##########################

# Download the training set
train <- read.table('../UCI HAR Dataset/train/X_train.txt',header = FALSE,sep = "", dec = ".")
#train is a 7352 x 561 set -> the columns correspond to the 561 variables in features.txt
#The rows correspond to which subject the measurement was taken from (see subject_train.txt)
#Create new column called "Subject" to indicate which subject the measurement was taken from
subject <- read.table('../UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep ="")
train$subject <- subject #for some reason called "subject.V1"
train$subject <-as.numeric(unlist(train$subject)) #need to turn column type from "dataframe" to "numeric"
#put the subject column first:
train <- train[,c(ncol(train),1:(ncol(train)-1))]

# Repeat process for the test set
test <- read.table('../UCI HAR Dataset/test/X_test.txt',header = FALSE,sep = "", dec = ".")
subject_test <- read.table('../UCI HAR Dataset/test/subject_test.txt',header = FALSE, sep ="")
test$subject <- subject_test 
test$subject <-as.numeric(unlist(test$subject))
test <- test[,c(ncol(test),1:(ncol(test)-1))]

# Merge the two datasets
merged_data <-rbind(train,test)

####################### Extract the mean and standard deviation measurements #######################
#import features.txt and search for titles containing "mean" or "std"
features <- read.table('../UCI HAR Dataset/features.txt',header = FALSE,sep = "")
features$V2 <- as.character(features$V2) #convert factor data type to string
colInds <- grep("mean|std",features$V2, ignore.case = TRUE)

subset_data <- merged_data[,c(1,colInds+1)] #take only columns with mean or std (add 1 b/c subject is now col 1)

########################### Rename the activies in the data set #####################################


###################### Label the data set with descriptive variable names ###########################


## Create a second tidy data set with the average of each variable for each activity and each subject