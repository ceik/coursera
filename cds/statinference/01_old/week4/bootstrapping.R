library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)
B <- 10000
resamples <- matrix(sample(x, n * B, replace = T), B, n)
resamplesMedians <- apply(resamples, 1, median)
sd(resamplesMedians)
quantile(resamplesMedians, c(0.025, 0.975))
