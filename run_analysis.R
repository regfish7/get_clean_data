############### Merge the training and test sets to create one data set ##########################

# Download the training set
train <- read.table('../UCI HAR Dataset/train/X_train.txt',header = FALSE,sep = "", dec = ".")
#train is a 7352 x 561 set -> the columns correspond to the 561 variables in features.txt
#The rows correspond to which subject the measurement was taken from (see subject_train.txt)
#The dataset y_train (7352 x 1) gives the activity label for each row

#Create new column called "Subject" to indicate which subject the measurement was taken from
subject <- read.table('../UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep ="")
train$subject <- subject 
train$subject <-as.numeric(unlist(train$subject)) #need to turn column type from "dataframe" to "numeric"
#put the subject column first:
train <- train[,c(ncol(train),1:(ncol(train)-1))]

#Create a new column called "Activity" that gives the activity label for each row
train_labels <- read.table('../UCI HAR Dataset/train/y_train.txt')
train$activity <- train_labels
train$activity <- as.numeric(unlist(train$activity))
train <- train[,c(1, ncol(train), 2:(ncol(train)-1))] #put activity column second

# Repeat process for the test set
test <- read.table('../UCI HAR Dataset/test/X_test.txt',header = FALSE,sep = "", dec = ".")
subject_test <- read.table('../UCI HAR Dataset/test/subject_test.txt',header = FALSE, sep ="")
test$subject <- subject_test 
test$subject <-as.numeric(unlist(test$subject))
test <- test[,c(ncol(test),1:(ncol(test)-1))]
test_labels <- read.table('../UCI HAR Dataset/test/y_test.txt')
test$activity <- test_labels
test$activity <- as.numeric(unlist(test$activity))
test <- test[,c(1, ncol(test), 2:(ncol(test)-1))] #put activity column second

# Merge the two datasets
merged_data <-rbind(train,test)

####################### Extract the mean and standard deviation measurements #######################
#import features.txt and search for titles containing "mean" or "std"
features <- read.table('../UCI HAR Dataset/features.txt',header = FALSE,sep = "")
features$V2 <- as.character(features$V2) #convert factor data type to string
colInds <- grep("mean|std",features$V2, ignore.case = TRUE)

subset_data <- merged_data[,c(1:2,colInds+2)] #take only columns with mean or std (add 2 b/c subject and activity cols added)

########################### Rename the activies in the data set #####################################
# These activity names are based on the file activity_labels.txt
activity_labels <- read.table('../UCI HAR Dataset/activity_labels.txt')
subset_data$activity <- activity_labels[match(subset_data$activity, activity_labels$V1),]$V2

###################### Label the data set with descriptive variable names ###########################
#First, import variable names given in features.txt
feature_names <- read.table('../UCI HAR Dataset/features.txt')

#Rename these variables so that they are more descriptive
feature_names$V2 <- gsub('^t','Time',feature_names$V2)
feature_names$V2 <- gsub('^f','Freq',feature_names$V2)
feature_names$V2 <- gsub('[[:punct:]]+','',feature_names$V2)
feature_names$V2 <- gsub('mean','Mean', feature_names$V2)
feature_names$V2 <- gsub('std','Std', feature_names$V2)

#Rename columns with the updated feature names
#first, change column names to just be numeric to match feature_names codes
colnames(subset_data)<- gsub('V','',colnames(subset_data))

#rename
for(name in colnames(subset_data[3:length(subset_data)])){
    names(subset_data)[names(subset_data)==name]<-feature_names[feature_names$V1==name,'V2']
}


    
## Create a second tidy data set with the average of each variable for each activity and each subject
tidy_data = aggregate(subset_data, by= list(subset_data$subject,subset_data$activity),FUN = mean)
tidy_data <-rename(tidy_data,replace = c('Group.1'='Subject', 'Group.2'='Activity' ))
tidy_data <- subset(tidy_data, select = -c(subject,activity))
tidy_data <- tidy_data[order(tidy_data$Subject),]

#Re-index row
row.names(tidy_data) <- 1:nrow(tidy_data)

## Export the dataset
write.csv(tidy_data, file = 'tidydata.csv',row.names=FALSE)