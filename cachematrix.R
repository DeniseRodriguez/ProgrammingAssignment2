## This program writes an R function that is able to cache potentially
## time-consuming computations.  This function uses a matrix.

## Use the <<- operator to assign a value to an object in an environment
## that is different from the current environment.  This is an example
## of lexical scoping.

## This function creates a special "matrix" object that can cache its inverse

## It contains 4 functions:
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
        i <- NULL

## set() set the value of x and set i to NULL
        set <- function (y) {
                x <<- y
                i <<- NULL
        }

## get() retrieves the value of x from the parent environment
        get <- function() x

## setinverse() uses solve to set the inverse
        setinverse <- function(solve) i <<- solve

## getinverse() retrieves the inverse
        getinverse <- function() i

## creates a named list of the four functions which allows the use
## of the $ form of the extract operator to access the functions by name
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}

## This function computes the inverse of the special "matrix" returned
## by makeCacheMatrix.  It retrieves it if the inverse has already been calculated.

cacheSolve <- function(x, ...) {
        i <- x$getinverse()

## If the inverse has been cached, the inverse is retrieved and returned
        if(!is.null(i)) {
                message("getting cached data")
                return(i)
        }

## If the matrix has changed, calculate the inverse
## using new matrix (X$get)
        data <- x$get()

## Solve for the inverse of the new matrix
        i <- solve(data, ...)

## Set the cache
        x$setinverse(i)
        i
}

## To Test Functions:
## create two matrices
##      m1 <- matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2)
##      n1 <- matrix(c(6,2,8,4), nrow = 2, ncol = 2)

## m1 is the inverse of n1 and n1 is the inverse of m1

## assign the makeCacheMatrix function using m1 to a variable
##      aMatrix <- makeCacheMatrix(m1)

## retrieve the value of x
##      aMatrix$get()

## retrieve the value of i
##   i will be NULL before cacheSolve is run
##   i will contain the inverse from cache after cacheSolve is run
##      aMatrix$getinverse

## reset the value with a new matrix
##      aMatrix$set(n1)

## set the inverse of n1
##      cacheSolve(aMatrix)
