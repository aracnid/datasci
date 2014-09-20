## Instructions
You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Plan
- create the _train_ data frame
  - create a _train_ data frame with "train/X_train.txt", take feature names from "features.txt"
  - slice the mean()/std() features, not meanFreq()
  - add activities feature to the train df from "train/y_train.txt"
  - join with "activity_labels.txt" to replace activity number with label
- create the _test_ data
  - create a _test_ data frame with "test/X_test.txt", take feature names from "features.txt"
  - slice the mean()/std() features
  - add activities feature to the test df from "test/y_test.txt"
  - join with "activity_labels.txt" to replace activity number with label
- append test df to train df

- second data set contains the average of each variable for each activity and each subject


## Notes
- mean() and std()
- <measurement>-mean()[-(X|Y|Z)]
- <measurement>-std()[-(X|Y|Z)]
- make sure the activity number feature is removed once the label feature is added to the data frame
- add "y_train.txt" which contains column of activities, **join** with "actvity_labels.txt"

## Grading Criteria
1. Please upload the tidy data set created in step 5 of the instructions.  Please upload your data set as a txt file created with write.table() using row.name=FALSE.
  - Has the student submitted a tidy data set?
2. Please submit a link to a GitHub repo with the code for performing your analysis.  The code should have a file "run_analysis.R" in the main directory that can be run as long as the Samsung data is in your working directory.  The output should be the tidy data set you submitted for part 1.  You should include a README.md in the repo describing how the script works and the code book describing the variables.
  - Did the student submit a Github repo with the required scripts?
  - Was code book submitted to GitHub that modifies and updates the codebooks available to you with the data to indicate all the variables and summaries you calculated, along with units, and any other relevant information?
  - I was able to follow the README in the directory that explained what the analysis files did.
### Overall evaluation/feedback
- As far as you can determine, does it appear that the work submitted for this project is the work of the student who submitted it?
- Please use the space below to provide constructive feedback to the student who submitted the work.  Point out the submission's strengths as well as areas in need of improvement.  You may also use this space to explain your grading decisions.