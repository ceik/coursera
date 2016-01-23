### No true positives

set.seed(1010093)
pValues <- rep(NA, 1000)
for (i in 1:1000) {
    y <- rnorm(20)
    x <- rnorm(20)
    pValues[i] <- summary(lm(y~x))$coeff[2,4]
}
sum(pValues < 0.05)
sum(p.adjust(pValues, method = "bonferroni") < 0.05)
sum(p.adjust(pValues, method = "BH") < 0.05)



### 50% true positives

set.seed(1010093)
pValues <- rep(NA, 1000)
for (i in 1:1000) {
    x <- rnorm(20)
    ### First 500 beta=0, last 500 beta=2
    if(i <= 500) {y <- rnorm(20)} else {y <- rnorm(20, mean = 2*x)}
    pValues[i] <- summary(lm(y~x))$coeff[2,4]
}
trueStatus <- rep(c("zero", "not zero"), each=500)
table(pValues < 0.05, trueStatus)
table(p.adjust(pValues, method = "bonferroni") < 0.05, trueStatus)
table(p.adjust(pValues, method = "BH") < 0.05, trueStatus)
