### Data example for student t-test


### Treating sleep data as paired data (correct)

data(sleep)

g1 <- sleep$extra[1:10]
g2 <- sleep$extra[11:20]
difference <- g2 - g1
mn <- mean(difference)
s <- sd(difference)
n <- 10

mn + c(-1, 1) * qt(0.975, n-1) * s / sqrt(n)
t.test(difference)
t.test(g2, g1, paired = T)
t.test(extra ~ I(relevel(group,2)), paired = T, data = sleep)



### Treating sleep data as independent group data 
### (incorrect but assumed for example)

data(sleep)

g1 <- sleep$extra[1:10]
g2 <- sleep$extra[11:20]
n1 <- length(g1); n2 <- length(g2)
mdiff <- mean(g2) - mean(g1)
sp <- sqrt(((n2 - 1) * sd(g2)^2 + (n1 - 1) * sd(g1)^2) / (n1+n2-2))
semdiff <- sp * (1/n1 + 1/n2)^0.5
mdiff + c(-1,1) * qt(0.975, n1 + n2 - 2) * semdiff
t.test(g2, g1, paired = F, var.equal = T)



### ChickWeight Example
### ChickWeight data is on Chick, Diet, Time level and gives weight values
library(reshape2); library(datasets); data(ChickWeight); library(dplyr)
### Change level of data to Diet, Chick level and add columns for each possible
### Time dimension. Value column is set to Weight. 
wideCW <- dcast(ChickWeight, Diet + Chick ~ Time, value.var = "weight")
names(wideCW)[-(1:2)] <- paste("time", names(wideCW)[-(1:2)], sep = "")
wideCW <- mutate(wideCW, gain = time21 - time0)
wideCW14 <- subset(wideCW, Diet %in% c(1, 4))
### variable ~ model can only be used for 2 different model values
t.test(gain ~ Diet, paired = F, var.equal = T, data = wideCW14)












