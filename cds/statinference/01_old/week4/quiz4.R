### 1
base <- c(140, 138, 150, 148, 135)
w2 <- c(132, 135, 151, 146, 130)
t.test(base, w2, alt = "two.sided", paired = T)

### 2
1100 + c(1, -1) * qt(0.975, 8) * 30/sqrt(9)

### 3
binom.test(3,4, alt="g")

### 4
binom.test(10, 1787, p = 0.01, alt="l")

### 5
sp = (8*1.5^2 + 8*1.8^2)/16
t <- (1+3)/sqrt(sp)
pt(t, 16, lower.tail = F)

### 7
power.t.test(n=100, delta=0.01, sd=0.04, alt="one.sided", type="one.sample")

### 8
power.t.test(power=0.9, delta=0.01, sd=0.04, alt="one.sided", type="one.sample")
