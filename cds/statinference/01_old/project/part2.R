library(datasets)
library(reshape2)
library(dplyr)
data(ToothGrowth)

summary(ToothGrowth)

oj <- subset(ToothGrowth, supp == "OJ")
vc <- subset(ToothGrowth, supp == "VC")
tg0.5 <- subset(ToothGrowth, dose == 0.5)
tg1 <- subset(ToothGrowth, dose == 1.0)
tg2 <- subset(ToothGrowth, dose == 2.0)
tg0.5_1 <- subset(ToothGrowth, dose %in% c(0.5, 1))
tg0.5_2 <- subset(ToothGrowth, dose %in% c(0.5, 2))
tg1_2 <- subset(ToothGrowth, dose %in% c(1, 2))


t.test(len ~ dose, paired=F, var.equal=T, data=tg0.5_1)
t.test(len ~ dose, paired=F, var.equal=T, data=tg0.5_2)
t.test(len ~ dose, paired=F, var.equal=T, data=tg1_2)

t.test(len ~ supp, paired=F, var.equal=T, data=tg0.5)
t.test(len ~ supp, paired=F, var.equal=T, data=tg1)
t.test(len ~ supp, paired=F, var.equal=T, data=tg2)


cor(oj$len, oj$dose)
cor(vc$len, vc$dose)
plot(ToothGrowth$len, ToothGrowth$dose)
plot(oj$len, oj$dose)
plot(vc$len, vc$dose)
plot(tg0.5$len, tg0.5$supp)
plot(tg1$len, tg1$supp)
plot(tg2$len, tg2$supp)
