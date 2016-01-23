#####    Conditional Probabilty    #####
########################################

# Definition: For an event B with P(B) > 0, the conditional probability of an
#             event A given that B has occured is:
#             P(A|B) = P(A n B) / P(B)
# If A and B and statistically independent this becomes:
# P(A|B) = P(A)P(B) / P(B) = P(A)


### Baye's Rule

# P(B|A) = (P(A|B) * P(B)) / (P(A|B) * P(B) + P(A|B^c) * P(B^c))

# This is useful for example for diagnostic tests: Let + and - be the events 
# that the result of a diagnostic test is positive or negative respectively. 
# Also let D and D^c (pronounced D complement) be the event that the subject of
# the test has or does not have the disease respectively.

# Sensitivity: P(+|D)
# Specificity: P(-|D^c)
# Both these parameters should be high for a good test.

# Prevalence of the disease: P(D)
# Positive Predictive Value: P(D|+)
# Negative Predictive Value: P(D^c|-)

# See video 03_02 for a good example and more information on Likelihood ratios.


### Independence

# Definition: Event A is independent of event B if:
#             P(A|B) = P(A), where P(B) > 0
#             or P(A n B) = P(A) * P(B)

# See video 03_03 for a good example.

# RVs are said to be independent and identically distributed (iid) if:
# - They are statistically unrelated from each other (independent)
# - Have all been drawn from the same distribution (identically distributed)
# iid sampling is often the default model for sampling, even if that doesn't 
# hold 100% true.