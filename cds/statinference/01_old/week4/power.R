mu0 = 30; mua = 32; sigma = 4; n = 16; alpha = 0.05
z <- qnorm(1 - alpha)
pnorm(mu0 + z * sigma/sqrt(n), mean = mu0, sd = sigma/sqrt(n), lower.tail = F)
pnorm(mu0 + z * sigma/sqrt(n), mean = mua, sd = sigma/sqrt(n), lower.tail = F)

power.t.test(n = 16, delta = 2, sd = 4, type = "one.sample", alt = "one.sided")$power
power.t.test(power = 0.8, delta = 2, sd = 4, type = "one.sample", alt = "one.sided")$n
