library(UsingR); data(father.son);
x <- father.son$sheight
(mean(x) + c(-1, 1) * qnorm(0.975) * sd(x)/sqrt(length(x)))/12


0.56 + c(-1, 1) * qnorm(0.975) * sqrt(0.56*0.44/100)
binom.test(56, 100)$conf.int


### Binom Coverage simulation. Shows that for large/small p, a larger n is
### required for the CI calculation to actually work: In the first case p falls
### not between the ul and ll on many more than 5% of the cases. This means
### the lower and upper limits are not correct. Increasing n lowers the severity
### of the problem. binom.test would calculate the accurate CIs

n <- 20
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage <- sapply(pvals, function(p){
    phats <- rbinom(nosim, prob = p, size = n)/n
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})

n <- 100
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage2 <- sapply(pvals, function(p){
    phats <- rbinom(nosim, prob = p, size = n)/n
    ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
    mean(ll < p & ul > p)
})


### Posssion Interval based on sample:

x <- 5
t <- 94.32
lambda <- x/t
round(lambda + c(-1,1) * qnorm(0.975) * sqrt(lambda/t), 3)


### Exact poisson interval
poisson.test(x, T = 94.32)



### Poisson coverage simulation
lambdavals <- seq(0.005, 0.1, by = 0.001)
nosim <- 100000
t <- 1000
### for every rate (lambdaval), generate a bunch of random poissons for our
### monitoring time. Then use the standard error to construct the lower and
### uppler limit of our CI. Then take the percentage of times that my interval
### contains the true lambda used for simulation.
coveragel <- sapply(lambdavals, function(lambda) {
    lhats <- rpois(nosim, lambda = lambda * t)/t
    ll <- lhats - qnorm(0.975) * sqrt(lhats/t)
    ul <- lhats + qnorm(0.975) * sqrt(lhats/t)
    mean(ll < lambda & ul > lambda)
})

plot(coveragel)
text(coveragel, labels = lambdavals, cex = 0.7)





