# run_analysis.R

library(reshape2)

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each 
#  measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# Creates a second, independent tidy data set with the average of each variable 
#  for each activity and each subject. 

# The data linked to from the course website represent data collected from the 
# accelerometers from the Samsung Galaxy S smartphone. A full description is 
# available at the site where the data was obtained: 
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

feature_labels_file <- "UCI HAR Dataset/features.txt"
activity_labels_file <- "UCI HAR Dataset/activity_labels.txt"
train_file <- "UCI HAR Dataset/train/X_train.txt"
train_labels_file <- "UCI HAR Dataset/train/y_train.txt"
train_subject_file <- "UCI HAR Dataset/train/subject_train.txt"
test_file <- "UCI HAR Dataset/test/X_test.txt"
test_labels_file <- "UCI HAR Dataset/test/y_test.txt"
test_subject_file <- "UCI HAR Dataset/test/subject_test.txt"

get_file <- function(file,colnames) {
	file <- read.table(file,
					   stringsAsFactors=FALSE,
					   col.names=colnames)
	return(file)
}

# Read in feature labels to use for col names. Clean up to make easier to read.
feature_labels <- get_file(feature_labels_file)
# feature names needs to be a character vector for assignmment to colnames
feature_names <- as.character(feature_labels$V2)  
feature_names <- gsub("-", "_", feature_names)
feature_names <- gsub("\\(\\)", "", feature_names)

# Read in data
# data.table method fread() is a lot faster but does not handle separation
# by more than one space. Some rows in the raw data set contain two spaces. 

train_subject_df <- get_file(train_subject_file,colnames="subject")
train_labels <- get_file(train_labels_file,colnames="activity")
train_df <- get_file(train_file,colnames=feature_names)

test_subject_df <- get_file(test_subject_file,colnames="subject")
test_labels <- get_file(test_labels_file,colnames="activity")
test_df <- get_file(test_file,colnames=feature_names)

# Add col1 with subject data for both train and test sets.
# Add col2 with activity data for both train and test sets.

train <- cbind(train_subject_df, train_labels, train_df)
test <- cbind(test_subject_df, test_labels, test_df)

# Append test data to train data.
# Create data table with 561 cols (feature vector + 2 cols) and rbind data
dt <- data.frame(matrix(nrow=0,ncol=563))
dt <- rbind(dt,train)
dt <- rbind(dt,test)

# Improve activity labeling by re-mapping with descriptive data as levels. 
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

# head(dt[,1:5],5)
activities <- read.table(activity_labels_file, stringsAsFactors=TRUE)

dt[,1] <- as.factor(dt[,1])  # Make the subject a factor
dt[,2] <- as.factor(dt[,2])  # Make the activity type a factor
levels(dt[,2]) <- levels(activities[,2]) # re-level activity

# find col values with _mean and _std and subset out other feature vectors
tidy_dt <- dt[c("subject", "activity", grep("mean|std", names(dt), value = TRUE))]

# Create summary file that averages each variable for each activity and each 
# subject
# Should produce a tidy table like this:
# subject           activity        variable       value
# 1        1 WALKING_DOWNSTAIRS tBodyAcc_mean_X  0.28858451
# 2        1 WALKING_DOWNSTAIRS tBodyAcc_mean_X  0.27841883
# 3        1 WALKING_DOWNSTAIRS tBodyAcc_mean_X  0.27965306
# ...

molten <- melt(tidy_dt)  	# First two cols are factors so uses these
							# as id vars

# Get means where subject and activity are the same
# Should look something like this:
# subject           activity tBodyAcc_mean_X tBodyAcc_mean_Y tBodyAcc_mean_Z 
# 1       1             LAYING       0.2773308    -0.017383819      -0.1111481    
# 2       1            SITTING       0.2554617    -0.023953149      -0.0973020
# ...

means <- dcast(molten, subject + activity ~ variable, mean)

write.table(means,
	file="summary_average_by_subject_activity.csv",
	sep=",",
	row.names=FALSE,
	col.names=TRUE)