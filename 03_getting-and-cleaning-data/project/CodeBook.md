# Codebook
### Source Data
The source data is contained in the **data/** directory relative to the R script.
The source data is described in detail in the files **data/README.md** and **data/features_info.txt** and is summarized here.  The source data is not contained in this repository.

The main data sets are found in the files **data/train/X_train.txt** and **data/test/X_test.txt**.  The main data sets contain 561 measurement variables.  The list of features is described in the file **data/features.txt**.

There are two additional variables that are contained in separate files:
- The _activity label_ variable is contained in the files **data/train/y_train.txt** and **data/test/y_test.txt**.  This variable is numeric and is described in the file **data/activity_labels.txt**.
- The _subject_ who performed the activity is contained in the files **data/train/subject_train.txt** and **data/test/subject_test.txt**.

### Output Data
The output data is a summary table that contains the averages of each of the mean() and std() features, separated by subject and activity.
- _Row 1_:  `subject`
- _Row 2_:  `activity`
- _Rows 3-68_:  mean() and std() features

### Data Transformations
The following is a sequential list of data transformations that were performed on the source data to produce the output data.

1. The training data was read into a data frame (`df`).
2. The unnecessary feature columns were dropped.  The remaining columns were all mean() ans std() measurements.
3. The `subject` column was added from **data/train/subject_train.txt**.
4. The `activity_num` column was added from **data/train/y_train.txt**
5. The `activity` label column was added by merging the training data frame with a data frame containing the labels from **data/activity_labels.txt**.
6. Then the `activity_num` column was dropped.
7. The test data was read into a data frame by repeating steps 1-6 on the test data set.
8. The training data frame was combined with the test data frame to form the full data set.
9. Using the `ddply()` function on the full data set, the data frame was split on `subject` and `activity` and a column-wise mean was calculated on each feature variables.  The result was returned as another data frame.
10. Finally, the averages data frame was written to the file **tidy.txt**.

### R Script Variables
Global variables:
- `NUMROWS`:  the number of rows to read from the data sets or -1 to read all the rows
- `TABLE_FEATURES`:  the data frame created from **data/features.txt**
- `TABLE_LABELS`:  the data frame created from **data/activity_labels.txt**
- `FEATURES`:  the list of features
- `COL_NAMES`:  the list of column names used in the training and test data frames, modified from the list of features
- `INCLUDE_COLS`:  a boolean list used to drop unnecessary columns
- `train`:  the training data frame
- `test`:  the test data frame
- `full`:  the full data frame created by combining the training and test data frames
- `averages`:  the output tidy data frame containing the averages of the features by subject and activity

function:  getData(filename)
- `df`:  a raw data frame
- `dfSliced`:  a sliced data frame
- `path`:  a temporary used to determine the filename of the subject data set
- `filenameSubjects`:  the filename of the subject data set
- `tableSubjects`:  the data frame created from the subject data set
- `filenameActivities`:  the filename of the activity labels
- `tableActivities`:  the data frame create from the activity labels data set
- `dfJoined`:  the joined data frame from the merging of `dfSliced` and `TABLE_LABELS`

## Appendix. Columns in the Output Data
The following is a list of the columns found in the output data set, **tidy.txt**.  The names of the mean() and std() features was modified slightly from the original set described in the file **data/features.txt**.  The reason is that the data frame structure does not render symbols in the names of the columns.  Dashes ("-") were replaced by underscores ("\_") and parentheses were removed.  For example, the original feature named, "tBodyAcc-mean()-X", was renamed to "tBodyAcc\_mean\_X".

```
subject
activity
tBodyAcc_mean_X
tBodyAcc_mean_Y
tBodyAcc_mean_Z
tBodyAcc_std_X
tBodyAcc_std_Y
tBodyAcc_std_Z
tGravityAcc_mean_X
tGravityAcc_mean_Y
tGravityAcc_mean_Z
tGravityAcc_std_X
tGravityAcc_std_Y
tGravityAcc_std_Z
tBodyAccJerk_mean_X
tBodyAccJerk_mean_Y
tBodyAccJerk_mean_Z
tBodyAccJerk_std_X
tBodyAccJerk_std_Y
tBodyAccJerk_std_Z
tBodyGyro_mean_X
tBodyGyro_mean_Y
tBodyGyro_mean_Z
tBodyGyro_std_X
tBodyGyro_std_Y
tBodyGyro_std_Z
tBodyGyroJerk_mean_X
tBodyGyroJerk_mean_Y
tBodyGyroJerk_mean_Z
tBodyGyroJerk_std_X
tBodyGyroJerk_std_Y
tBodyGyroJerk_std_Z
tBodyAccMag_mean
tBodyAccMag_std
tGravityAccMag_mean
tGravityAccMag_std
tBodyAccJerkMag_mean
tBodyAccJerkMag_std
tBodyGyroMag_mean
tBodyGyroMag_std
tBodyGyroJerkMag_mean
tBodyGyroJerkMag_std
fBodyAcc_mean_X
fBodyAcc_mean_Y
fBodyAcc_mean_Z
fBodyAcc_std_X
fBodyAcc_std_Y
fBodyAcc_std_Z
fBodyAccJerk_mean_X
fBodyAccJerk_mean_Y
fBodyAccJerk_mean_Z
fBodyAccJerk_std_X
fBodyAccJerk_std_Y
fBodyAccJerk_std_Z
fBodyGyro_mean_X
fBodyGyro_mean_Y
fBodyGyro_mean_Z
fBodyGyro_std_X
fBodyGyro_std_Y
fBodyGyro_std_Z
fBodyAccMag_mean
fBodyAccMag_std
fBodyBodyAccJerkMag_mean
fBodyBodyAccJerkMag_std
fBodyBodyGyroMag_mean
fBodyBodyGyroMag_std
fBodyBodyGyroJerkMag_mean
fBodyBodyGyroJerkMag_std
```
