#####    Quiz 2    #####
########################

### Question 2

library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)
BodyWeight


### Question 4

library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)


### Question 7

library(datasets)
data(airquality)
class(airquality$Month)

qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))

airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)


### QUestion 9

library(ggplot2)
movies
g <- ggplot(movies, aes(x=votes, y=rating))
print(g)
summary(g)
g + geom_point()


### QUestion 10

qplot(votes, rating, data = movies) + stats_smooth("loess")

qplot(votes, rating, data = movies) + geom_smooth()

qplot(votes, rating, data = movies, panel = panel.loess)

qplot(votes, rating, data = movies, smooth = "loess")