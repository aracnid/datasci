library(plyr)

NUMROWS <- -1    # set to -1 to read all rows
TABLE_FEATURES <- read.table("data/features.txt", sep="")
TABLE_LABELS <- read.table("data/activity_labels.txt", sep="", col.names=c("activity_num", "activity"))
FEATURES <- TABLE_FEATURES$V2
# process the names to remove symbols, data frame col.names don't like symbols
COL_NAMES <- lapply(FEATURES, function(X) gsub("\\(|\\)", "", gsub("-", "_", X)))
# create an include list to extract only the mean() and std() features
INCLUDE_COLS <- grep("mean\\(\\)|std\\(\\)", FEATURES)
# write extracted features list for codebook
write.table(unlist(COL_NAMES[INCLUDE_COLS]), "mod-features.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

# this function reads the "filename" and returns a data frame
getData <- function(filename) {
  # read the data into a data frame
  df <- read.table(filename, sep="", nrows=NUMROWS, col.names=COL_NAMES)
  
  # extract only the mean() and std() features
  dfSliced <- df[INCLUDE_COLS]
  
  # add the subject to the data frame
  path <- unlist(strsplit(filename, "/"))
  path[length(path)] <- paste(c("subject", "_", path[length(path)-1], ".txt"), collapse="")
  filenameSubjects <- paste(path, collapse="/")
  tableSubjects <- read.table(filenameSubjects, nrows=NUMROWS)
  dfSliced$subject <- tableSubjects[,1]
  
  # add the activities feature to the data frame
  filenameActivities <- sub("X", "y", filename)
  tableActivities <- read.table(filenameActivities, nrows=NUMROWS)
  dfSliced$activity_num <- tableActivities[,1]  # actnum is a data frame, slice it to get a list of ints
  
  # join with "activity_labels.txt" to add the activity names
  dfJoined <- merge(dfSliced, TABLE_LABELS, by="activity_num", all.x=TRUE)
  
  # drop the activity_num variable
  dfJoined$activity_num <- NULL
  
  # return the data frame
  return(dfJoined)
}

# get the training data
train <- getData("data/train/X_train.txt")

# get the test data
test <- getData("data/test/X_test.txt")

# combine the training and test data set
full <- rbind(train, test)

# find the average of each variable for each activity and each subject
averages <- ddply(full, .(subject, activity), function(df) colwise(mean)(df))

# write the data frame to a file
write.table(averages, "tidy.txt", row.names=FALSE)
