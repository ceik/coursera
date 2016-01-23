install.packages("UsingR")
library(UsingR); data(father.son);
x <- father.son$sheight
n <- 10
round(c(var(x), var(x) / n, sd(x), sd(x) / sqrt(n)), 2)
