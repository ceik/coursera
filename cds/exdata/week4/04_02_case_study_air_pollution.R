#####    Case Study - Air Pollution    #####
############################################

setwd("C:/Chris/cds/exdata/week4")


# Get 1999 Data 
pm0 <- read.table("RD_501_88101_1999-0.txt", comment.char = "#", header = F,
                  sep = "|", na.strings = "")

dim(pm0)
head(pm0)

cnames <- readLines("RD_501_88101_1999-0.txt", 1)
cnames <- strsplit(cnames, "|", fixed = T)
class(cnames)
class(cnames[[1]])

names(pm0) <- cnames[[1]]
head(pm0)

# in order to get rid of the spaces in the names:
names(pm0) <- make.names(cnames[[1]])
head(pm0)

x0 <- pm0$Sample.Value
class(x0)
str(x0)
summary(x0)
mean(is.na(x0))


# Get 2012 Data
pm1 <- read.table("RD_501_88101_2012-0.txt", comment.char = "#", header = F,
                  sep = "|", na.strings = "")

dim(pm1)
names(pm1) <- make.names(cnames[[1]])
head(pm1)
x1 <- pm1$Sample.Value

summary(x1)
summary(x0)
mean(is.na(x1))
boxplot(x0,x1)
boxplot(log10(x0), log10(x1))

negative <- x1 < 0
str(negative)
sum(negative, na.rm = T)
mean(negative, na.rm = T)

dates <- pm1$Date
str(dates)
dates <- as.Date(as.character(dates), "%Y%m%d")
str(dates)
hist(dates, "month")
hist(dates[negative], "month")

site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
head(site0)
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")
str(site0)
str(site1)
both <- intersect(site0, site1)
both

pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
head(cnt0)

sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)


pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)

dim(pm0sub)
dim(pm1sub)

dates1 <- pm1sub$Date
dates0 <- pm0sub$Date
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
x1sub <- pm1sub$Sample.Value
x0sub <- pm0sub$Sample.Value

plot(dates1, x1sub)
plot(dates0, x0sub)

par(mfrow = c(1,2), mar = c(4,4,2,1))
plot(dates0, x0sub, pch = 20)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20)
abline(h = median(x1sub, na.rm = T))

rng <- range(x0sub, x1sub, na.rm = T)
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x1sub, na.rm = T))


# Looking at state level
head(pm1)
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm=T))
str(mn0)
summary(mn0)
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm=T))
str(mn1)
summary(mn1)

d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)
head(d0)
head(d1)

mrg <- merge(d0, d1, by = "state")
dim(mrg)
head(mrg)

par(mfrow = c(1,1))
with(mrg, plot(rep(1999, 53), mrg[, 2], xlim = c(1999, 2014)))
with(mrg, points(rep(2013, 53), mrg[, 3]))
segments(rep(1999, 53), mrg[, 2], rep(2013, 53), mrg[, 3])
