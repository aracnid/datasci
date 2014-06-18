corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations

	files <- list.files(directory)
	corr_vector <- numeric(0)

	for (file in files) {
		filename <- paste(directory, "/", file, sep="")
		data <- read.table(filename, header=TRUE, sep=",")

		data_complete <- complete.cases(data)

		if (sum(data_complete) > threshold) {
			data_sub <- subset(data, data_complete, select=c(2, 3))
			#print(dim(data_sub))
			#break
			# do corr stuff here
			corr_vector <- append(corr_vector, cor(data_sub[1], data_sub[2]))
		}
	}
	
	corr_vector

}