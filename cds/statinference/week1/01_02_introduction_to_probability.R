#####    Probability    #####
#############################


### Introduction

# Probability: Given a random experiment (e.g. rolling a die) a probability
#              measure is a population quantity that summarizes the randomness.
# Specifically, probability takes a possible outcome and assigns it a number 
# between 0 and 1.


# Rules that probability must follow:
# 1. The probability that nothing occurs is 0
# 2. The probability that something occurs is 1
# 3. The probability of something is 1 minus the probability that the opposite
#    occurs
# 4. the probability of the union of any two sets of outcomes that have
#    nothing in common (mutually exclusive) is the sum of their respective
#    probabilities.
#    P(A u B) = P(A) + P(B)
# 5. If event A implies the occurance of event B, then the probability of A
#    occuring is less than the probability that B occurs.
# 6. For any two events, the probability that at least one occurs is the sum
#    of their probabilities minus the intersection.
#    P(A u B) = P(A) + P(B) - P(A n B)

# Random Variable (RV): Numeric outcome of an experiment
# Discrete: A RV that is discrete can be counted (die-roll, webhits, hair color)
# Continuous: Continuous RVs can take any value in a continuum.

# Everything discussed below regards the population, not actually observed data!


### Probability Mass Functions

# Probability Mass Functions (PMF) are used to model probabilities for discrete
# RVs. Evaluated at a value it corresponds to the probability that a RV takes 
# that value. It must always be greater than or equal to 0 and the sum of the 
# probabilities for a RV must add up to 1.

# An upper case letter will represent a potentially unrealized value of the RV.
# A lower case letter will represent a placeholder that any value can be plugged
# into.

# Example PMF for a (fair) coin flip: p(x) = (1/2)^x * (1/2)^(1-x) for x = 0, 1
# In reality the probability is often unknown and can be replaced in a more
# general PMF for a coin flip: p(x) = t^x * (1-t)^(1-x) for x = 0, 1 and
# t = probability of one of the two outcomes.


### Probability Density Functions

# Probability Density Functions (PDF) models probabilities for continuous RVs.
# The total area under the curve must be one and it must be greater than or 
# equal to zero everywhere. The area under the curve corresponds to the proba-
# bility of the interval.

x <- c(-0.5, 0, 1, 1, 1.5)
y <- c(0, 0, 2, 0, 0)
plot(x, y, lwd = 3, frame = F, type = "l")

# Probability that 75% or less of all calls get addressed (using above curve)?
1.5 * 0.75/2
# The beta distribution can also be used.
pbeta(0.75, 2, 1)

# The cumulative distribution function (CDF) of a RV, X, returns the probability
# that the RV is less than or equal to the value x: F(x) = P(X <= x). pbeta() is
# an example of this.

# The survival furnction of a RV is defined as the probability that the random
# variable is greater than the value x: S(x) = P(X > x) = 1 - F(x)


### Quantiles 

# The ath (alphath) quantile of a distribution function F is the point xa to 
# that F(xa) = a
# A percentile is simply a quantile with a expressed as a percent. The median
# is the 50th percentile.

qbeta(0.5, 2, 1)