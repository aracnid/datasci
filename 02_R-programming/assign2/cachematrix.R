## These two functions work together to provide a cached inverse matrix.

## This function is a matrix wrapper that contains an inverse matrix cache.

makeCacheMatrix <- function(x = matrix()) {
	## initialize the inverse matrix
	inv <- NULL

	## set the matrix
	set <- function(y) {
		x <<- y

		## reset inverse matrix
		inv <<- NULL
	}

	## get the matrix
	get <- function() x
	
	## set the inverse matrix
	setinv <- function(pinv) inv <<- pinv

	## get the inverse matrix
	getinv <- function() inv

	## return the list of functions
	list(set = set, get = get, setinv = setinv, getinv = getinv)
}


## This function returns a matrix that is the inverse of 'x'.
## If the inverse matrix is retrieved from a cache, if it had been calculated,
## otherwise it will be caculated and store in a cache for subsequent requests.

cacheSolve <- function(x, ...) {
	## get the inverse matrix from cache matrix, if it exists
	inv <- x$getinv()

	## return cached matrix if it was pre-computed
	if (!is.null(inv)) {
		## this message verifies that the result came from the cache
		message("getting cached data")
		return(inv)
	}

	## otherwise,
	## compute the inverse matrix
	data <- x$get()
	inv <- solve(data, ...)

	## set the inverse matrix cache
	x$setinv(inv)

	## return the inverse matrix
	inv
}
