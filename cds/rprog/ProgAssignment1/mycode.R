myfunction <- function() {
    x <- rnorm(100, mean = 0, sd = 1) 
    mean(x) 
}

second <- function(x) {
  x + rnorm(length(x))
}