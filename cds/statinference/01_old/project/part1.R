exp.dist <- rexp(1000, 0.2)
hist(exp.dist)


means <- NULL
for (i in 1:1000) {means = c(means, mean(rexp(40, 0.2)))}
hist(means)

vars <- NULL
for (i in 1:1000) {vars = c(vars, var(rexp(40, 0.2)))}
hist(vars)
mean(vars)



var(exp.dist)
mean(vars)
sd(vars)
var(means)



mean(exp.dist)
mean(means)

summary(means)
quantile(means, c(0.01, 0.05, 0.1, 0.9, 0.95, 0.099))
qnorm(c(0.01, 0.05, 0.1, 0.9, 0.95, 0.099), mean = mean(means), sd = sd(means))
