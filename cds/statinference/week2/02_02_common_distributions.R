#####    Common Distributions    #####
######################################

### Binomial Distribution Example

# Getting 7 or more girls from 8 births, assuming no twins and 50% chance of 
# getting a girl.

choose(8 ,7) * 0.5^7 * 0.5^1 + choose(8, 8) * 0.5^8 * 0.5^0
pbinom(6, size = 8, prob = 0.5, lower.tail = FALSE)


### Standard Distribution

# Getting a quantile (e.g. 95%)
qnorm(0.95, mean = 0, sd = 1)

# Probability that a N(mu, sig^2) is larger than x (e.g. 1.645)?
pnorm(1.645, mean = 0, sd = 1, lower.tail = F)
1 - pnorm(1.645, mean = 0, sd = 1)


### Poisson

# Mean of people showing up at bus stop: 2.5 per hour. Probability that 4 or
# fewer show up during 4h?

ppois(3, lambda = 2.5 * 4)

# Flip a coin with prop = 1% 500 times. Poisson here approximates a binomial 
# with very large n, but very small p.
# Whats the probability of 2 or fewer successes?

pbinom(2, size = 500, prob = 0.01)
ppois(2, lambda = 500 * 0.01)

# Binomial still works because n and p are not that extreme.