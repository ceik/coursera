choose(8,7) * 0.5 ^ 7 * (1 - 0.5)^1 + choose(8,8) * 0.5^8
pbinom(6, size = 8, prob = 0.5, lower.tail=F)
dbinom(7, size = 8, prob = 0.5) + dbinom(8, size = 8, prob = 0.5)
