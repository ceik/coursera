#####    Asymptotics    #####
#############################

### LLN Proof

n <- 1000

# For random nomrals:
means <- cumsum(rnorm(n))/(1:n)
plot(means, type = "l")
abline(h=0)

# For coin flip:
means_c <- cumsum(sample(0:1, n, replace = TRUE))/(1:n)
plot(means_c, type = "l")
abline(h=0.5)


### Confidence Intervals

# 95% Interval for Galtons data
library(UsingR)
data(father.son)
x <- father.son$sheight
(mean(x) + c(-1, 1) * qnorm(0.975) * sd(x)/sqrt(length(x)))/12
# Divide by 12 to get feet instead of inches

# 95% CI for Binomial data
# Out of 100 voters 56 say they'd vote for you. 95% confident that I get more 
# than 50% of vote?
0.56 + c(-1,1) * qnorm(0.975) * sqrt(0.56 * (1-0.56) / 100)

binom.test(56, 100)
binom.test(56, 100)$conf.int


### CI Simulation

n <- 20
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage <- sapply(pvals, function(p) {
    phats <- rbinom(nosim, prob = p, size = n)/n
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})
plot(coverage, type = "l")
abline(h=0.95)

# Same simulation again with a higher n
n <- 100
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage2 <- sapply(pvals, function(p) {
    phats <- rbinom(nosim, prob = p, size = n)/n
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})
plot(coverage2, type = "l")
abline(h=0.95)

# Agresti/Coull interval simulation with n = 20
n <- 20
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage <- sapply(pvals, function(p) {
    phats <- (rbinom(nosim, prob = p, size = n) + 2)/(n + 4)
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})
plot(coverage, type = "l")
abline(h=0.95)


### Poisson CIs

x <- 5
t <- 94.32
lam <- x/t
round(lam + c(-1,1) * qnorm(0.975) * sqrt(lam/t), 3)

poisson.test(x, T = t)
poisson.test(x, T = t)$conf

# Simulation for Poisson CIs
lambdavals <- seq(0.005, 0.1, by = 0.01)
nosim <- 1000
t <- 100
coverage3 <- sapply(lambdavals, function(lambda) {
    lhats <- rpois(nosim, lambda = lambda * t)/t
    ll <- lhats - qnorm(0.975) * sqrt(lhats/t)
    ul <- lhats + qnorm(0.975) * sqrt(lhats/t)
    mean(ll < lambda & ul > lambda)
})
plot(coverage3, type = "l")
abline(h = 0.95)

# Simulation for Poisson CIs with monitoring time increased to 1000
lambdavals <- seq(0.005, 0.1, by = 0.01)
nosim <- 1000
t <- 1000
coverage4 <- sapply(lambdavals, function(lambda) {
    lhats <- rpois(nosim, lambda = lambda * t)/t
    ll <- lhats - qnorm(0.975) * sqrt(lhats/t)
    ul <- lhats + qnorm(0.975) * sqrt(lhats/t)
    mean(ll < lambda & ul > lambda)
})
plot(coverage4, type = "l")
abline(h = 0.95)