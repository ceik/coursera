#####    T Confidence Intervals    #####
########################################


### t CIs

data(sleep)
sleep
g1 <- sleep$extra[1:10]
g2 <- sleep$extra[11:20]
difference <- g2 - g1
mean <- mean(difference)
sd <- sd(difference)
n <- 10

mean + c(-1,1) * qt(0.975, n-1) * sd / sqrt(n)
t.test(difference)
t.test(g1, g2, paired = T)
t.test(extra ~ I(relevel(group, 2)), paired = T, data = sleep)


### t CIs for Independent Groups

# Comparing data from an example from a textbook

mean1 <- 132.86
sd1 <- 15.34
n1 <- 8
mean2 <- 127.44
sd2 <- 18.23
n2 <- 21

varp <- sqrt(((n1-1) * sd1^2 + (n2-1) * sd2^2)/(n1+n2-2))
mean1 - mean2 + c(-1, 1) * qt(0.975, n1 + n2 - 2) * varp * sqrt(1/n1 + 1/n2)


# Chickweight Example

library(datasets)
library(reshape2)
library(dplyr)
data(ChickWeight)
head(ChickWeight)
wideCW <- dcast(ChickWeight, Diet + Chick ~ Time, value.var = "weight")
names(wideCW)[-(1:2)] <- paste("time", names(wideCW)[-(1:2)], sep = "")
wideCW <- mutate(wideCW, gain = time21-time0)
wideCW

# Comparing the first and last diet assuming equal and unequal variance:
wideCW14 <- subset(wideCW, Diet %in% c(1, 4))
rbind(
    t.test(gain ~ Diet, paired = F, var.equal = T, data = wideCW14)$conf,
    t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCW14)$conf
)