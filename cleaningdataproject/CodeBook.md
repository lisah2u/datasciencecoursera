# Codebook 

This codebook describes the variables, data, and transformations performed 
to clean up the original data set downloaded from here on 6/10/2014: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#>

in the production of **summary_average_by_subject_activity.csv**.

This csv contains 180 observations of 81 variables. The code which produced the 
csv is **run_analysis.R** in this directory.

By Column:

1. Subject - Factor with 30 levels (1-30)
2. Activity - Factor with 6 levels: 

		WALKING
		WALKING_UPSTAIRS
		WALKING_DOWNSTAIRS
		SITTING
		STANDING
		LAYING

Columns 3 - 81 are numeric means for features labeled as such:

	tBodyAcc_mean_X
	tBodyAcc_mean_Y
	tBodyAcc_mean_Y
	...

An intermediary dataframe was produced by merging feature vectors from:

	UCI HAR Dataset/train/X_train.txt 7352 (obs.)
	UCI HAR Dataset/test/X_test.txt (2947 obs.)
	
to a dataframe with 10299 observations.

Appended to this dataframe as column 1 were subject ids from:

	UCI HAR Dataset/train/subject_train.txt (1-30)
	UCI HAR Dataset/test/subject_test.txt (1-30)

Appended to this dataframe as column 2 were activities: 

	UCI HAR Dataset/train/y_train.txt (coded as above)
	UCI HAR Dataset/test/y_test.txt (coded as above)
	
All column features which did not contain "mean" or "std" were removed. The 
resultant intermediary dataframe contained 10299 observations of 81 variables. 

From this intermediary dataframe, summary statistics were calculated. 
Means were calculated for each feature by subject and activity.

The final table format (180 observations of 81 vars) is structured like this:

	 subject   activity tBodyAcc_mean_X tBodyAcc_mean_Y tBodyAcc_mean_Z 
      1        LAYING       0.2773308    -0.017383819      -0.1111481   
      1       SITTING       0.2554617    -0.023953149      -0.0973020   
      ...