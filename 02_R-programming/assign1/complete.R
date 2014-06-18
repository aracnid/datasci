complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

	files <- list.files(directory)

	data_complete <- data.frame(id=id, nobs=0)
	
	j <- 0
	for (i in id) {
		j <- j + 1
		filename <- paste(directory, "/", files[i], sep="")
		data <- read.table(filename, header=TRUE, sep=",")

		data_complete[j,"nobs"] <- sum(complete.cases(data))
	}

	data_complete
}