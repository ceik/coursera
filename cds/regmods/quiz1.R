#####    Quiz 1    #####
########################

# Question 1

x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)

x3 <- rep(x, times = w)

y <- x*w

mean(x3)

mu <- mean(x)

sum(w * (x - mu)^2)

sum(w * (x - 0.3)^2)
sum(w * (x - 0.1471)^2)
sum(w * (x - 0.0025)^2)
sum(w * (x - 1.077)^2)

# Choosing mu here even though mu2 gives a lower value (but is not an answer
# option)


# Question 2

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

sum((y - (x * 0.59915))^2)
sum((y - (x * -0.04462))^2)
sum((y - (x * -1.713))^2)
sum((y - (x * 0.8263))^2)


# Question 3

data(mtcars)

lm(mtcars$mpg ~ mtcars$wt)
lm(mtcars$wt ~ mtcars$mpg)
mtcars


# Question 4

0.5 * (1/0.5)


# Question 5

0.4 * 1.5


# Question 6

x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
mn <- mean(x)
s <- sd(x)
norm <- (x-mn)/s
norm


# Question 7

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y ~ x)


# Question 9

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mn <- mean(x)
sum((x - mn)^2)


# Question 10

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
cor(x, y)
cor(y,x)
