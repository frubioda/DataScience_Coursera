## Create two functions to store a matrix and return its inverse.
## Function1: creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()){
  m <- NULL
  set <- function(y){
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setInverse <- function(inverse) m <<- inverse
  getInverse <- function() m
  list(set=set, get=get, setInverse=setInverse, getInverse=getInverse)
}

## Function2: computes the inverse of the special matrix created by 
## makeCacheMatrix and retrieve the inverse.

cacheSolve <- function(x, ...) {
  m <- x$getInverse()
  if (!is.null(m)){
    message("getting cached matrix")
    return(m)
  }
  matrx <- x$get()
  m <- solve(matrx, ...)
  x$setInverse(m)
  return(m)
}
