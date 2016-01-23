#####    Multiple Testing    #####
##################################

# Case Study I: No True Positives

set.seed(1010093)
p_values <- rep(NA, 1000)
for (i in 1:1000) {
    y <- rnorm(20)
    x <- rnorm(20)
    p_values[i] <- summary(lm(y ~ x))$coeff[2, 4]
}

# Control Positive Rate
sum(p_values < 0.05)

# Control FWER
sum(p.adjust(p_values, method = "bonferroni") < 0.05)

# Control FDR
sum(p.adjust(p_values, method = "BH") < 0.05)



# Case Study II: 50% True Positives

set.seed(1010093)
p_values2 <- rep(NA, 1000)
for (i in 1:1000) {
    x <- rnorm(20)
    # First 500 beta=0, last 500 beta=2
    if (i<= 500) {
        y <- rnorm(20)
    } else {
        y <- rnorm(20, mean = 2 * x)
    }
    p_values2[i] <- summary(lm(y ~ x))$coeff[2, 4]
}
true_status <- rep(c("zero", "not zero"), each = 500)
table(p_values2 < 0.05, true_status)

# Controlling FWER
table(p.adjust(p_values2, method = "bonferroni") < 0.05, true_status)

# Controlling FDR
table(p.adjust(p_values2, method = "BH") < 0.05, true_status)

# Plotting the p values
par(mfrow = c(1, 3))
plot(p_values2, p_values2, pch = 19)
plot(p_values2, p.adjust(p_values2, method = "bonferroni"), pch = 19)
plot(p_values2, p.adjust(p_values2, method = "BH"), pch = 19)