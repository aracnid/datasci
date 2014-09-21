# Course Project
### List of files
The following is a listing of the files used for this project
- **README.md**:  This file.
- **CodeBook.md**:  Contains a detailed description of the original source data, the tidy output data set, the transformations that take place, and the script variables used to store and perform those transformations.
- **run\_analysis.R**:  The R code used to transform the original data into a tidy data set.
- **tidy.txt**:  The tidy output data set.  This data set summarized the averages of the mean() and std() features split by subject and activity.
- **mod-features.txt**:  A list of the features found in the tidy data set.  The feature names were modified slightly from the original feature names to work better in an R data frame.
- **todo.md**:  My notes for how to tackle this project.  This is not required for the project submission.
  
### Code description
The R code contains a sequence of commands and one custom function.  The custom function, called `getData()`, takes a filename and returns a data frame.  This function is called twice to create the training and test data frames.  The returned data frame is processed by adding the `subject` and `activity` data into separate columns.  The unnecessary feature columns are also dropped.

The training and test data sets are read and processed by the `getData()` function to form the `train` and `test` data frames.  These two data frames are combined to form a single data frame (`full`).  The full data set is then analyzed using `ddply` to calculate the averages of the features by subject and activity.
For more details, the R code is commented directly in the file.
