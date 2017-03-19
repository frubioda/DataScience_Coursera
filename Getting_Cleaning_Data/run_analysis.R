library(dplyr)
setwd("~/Coursera_DataAnalysis/course3/project/")
path <- getwd()

## DATA COLLECTED FROM THE ACCELEROMETERS FROM THE SAMSUNG GALAXY S SMARTPHONE
# Download data
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("dataset.zip")){
  download.file(fileurl, destfile="dataset.zip",method="curl")
}

# Uncompress zip file
if (file.exists("UCI HAR Dataset") == FALSE) {
  unzip("dataset.zip")
}

path_input <- file.path(path, "UCI HAR Dataset")
setwd(path_input)

# Read data
feature_names <- read.table("./features.txt",header=FALSE)[,2]
activity_labels <- read.table("./activity_labels.txt",header=FALSE)[,2]
# Read training data
subject_train <-read.table("./train/subject_train.txt", header=FALSE)
x_train <- read.table("./train/X_train.txt", header=FALSE)
y_train <- read.table("./train/y_train.txt", header=FALSE)
# Read test data
subject_test <-read.table("./test/subject_test.txt", header=FALSE)
x_test <- read.table("./test/X_test.txt", header=FALSE)
y_test <- read.table("./test/y_test.txt", header=FALSE)

# Merge training and test data
activity <- rbind(subject_train, subject_test)
subject <- rbind(y_train, y_test)
features <- rbind(x_train, x_test)

# Renaming the column labels
colnames(features) <- t(feature_names)
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"

# Merging all there dataset features
df <- cbind(features,activity,subject)

# Extract mean and standard deviation for each measurement. 
index_mean_stdev <- grep(".*[Mm]ean.*|.*[Ss]td.*", names(df), ignore.case=TRUE)
subset_mean_stdev <- df[,index_mean_stdev]

# Use descriptive activity names to name the activities in the data set
#Subset
df_subset <- cbind(subset_mean_stdev,activity,subject)
df_subset$Activity <- as.character(df_subset$Activity) #change the numeric class to character 
for (i in 1:length(activity_labels)){
  df_subset$Activity[df_subset$Activity == i] <- as.character(activity_labels[i])
}

#Full data
df$Activity <- as.character(df$Activity) #change the numeric class to character 
for (i in 1:length(activity_labels)){
  df$Activity[df$Activity == i] <- as.character(activity_labels[i])
}

# Appropriately labels the data set with descriptive variable names.
names(df) <- gsub("Acc", "Accelerometer", names(df)) #Acc replaced by Accelerometer
names(df) <- gsub("Gyro", "Gyroscope", names(df)) #Gyro replaced by Gyroscope
names(df) <- gsub("BodyBody", "Body", names(df)) #BodyBody replaced by Body
names(df) <- gsub("Mag", "Magnitude", names(df)) #Mag replaced by Magnitude
names(df) <- gsub("^t", "Time", names(df)) #"f" replaced by Frequency
names(df) <- gsub("^f", "Frequency", names(df)) #"t" replaced by Time
names(df) <- gsub("tBody", "TimeBody", names(df)) #tBody replaced by TimeBody
names(df) <- gsub("-mean()", "Mean", names(df), ignore.case = TRUE) #-mean() replaced by Mean
names(df) <- gsub("-std()", "StDev", names(df), ignore.case = TRUE) #-std() replaced by StDev
names(df) <- gsub("-freq()", "Frequency", names(df), ignore.case = TRUE) #-freq() replaced by Frequency
#names(df) <- gsub("angle", "Angle", names(df))
#names(df) <- gsub("gravity", "Gravity", names(df))

# Create tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(. ~ Subject + Activity, df, mean)
tidy_data <- tidy_data[order(tidy_data$Subject,tidy_data$Activity),]

#write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)
