#####    Dimension Reduction    #####
#####################################

### image() Experimentation

test <- matrix(1:200, nrow=10)
test
image(t(test))
image(1:10, 1:20, test)



### Patterns in Rows and Columns

set.seed(12345)
dm <- matrix(rnorm(400), nrow = 40)
dm
image(1:10, 1:40, t(dm) [, nrow(dm):1])

# There is no visible pattern here, which is expected. Similarly the heatmap 
# also shows no pattern. This is simply because there is no pattern in the data.
heatmap(dm)

# Adding a pattern to the data.
set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coin_flip <- rbinom(1, size=1, prob=0.5)
    # if coin is heads add a pattern to that row
    if (coin_flip) {
        dm[i,] <- dm[i,] + rep(c(0,3), each = 5)
    }
}
dm

# Plotting the heatmap again reveals a pattern in which some of the rows have a 
# mean of 3 in the first 5 and a mean of 0 in the last five columns. Because of
# this clear clusters in the columns emerge.
image(1:10, 1:40, t(dm) [, nrow(dm):1])
heatmap(dm)

# In order to visualize these patterns better different plots can be made using
# cluster analysis.
hh <- hclust(dist(dm))
hh$order
dm_ordered <- dm[hh$order,]
dm_ordered
par(mfrow = c(1,3))
image(t(dm_ordered)[, nrow(dm_ordered):1])
plot(rowMeans(dm_ordered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dm_ordered), xlab = "Column", ylab = "Column Mean", pch = 19)


### Related Problems

# In highly multivariate data sets there can be thousands or more variables.
# There often is at least some correlation between these variables. 
#
# One challenge is to define a new set of variables that are uncorrelated and 
# explain as much variance as possible. This is a statistical problem that can
# be solved via singular value decomposition.
#
# A second challenge is creating another matrix with fewer variables (lower 
# rank) that still explains the original data. This is a data compression 
# problem that can be solved via principle component analysis.


### Singular Value Decomposition

# If X is a matrix with each variable in a column and each observation in a row
# then the SVD is a matrix decomposition or matrix factorization. Factorization
# means decomposing and object into a product of simpler objects. E.g. 15 = 3*5
# or x^2 - 4 = (x-2) * (x + 2).
#
# X = UD(V^T) in which:
# U: Columns are orthogonal (left singular vectors)
# V: Columns are orthogonal (right singular vectors)
# D: Diagonal matrix (singular values). A diagonal matrix is one that only has
#    values on its diagonal.

# Plotting the first left singular vector of the svd visualizes the pattern in 
# the row means. Also the plot of the first right singular vectors visualizes
# the pattern in the column means.
dm_ordered
svd1 <- svd(scale(dm_ordered))
scale(dm_ordered)
svd1
par(mfrow = c(1,3))
image(t(dm_ordered) [, nrow(dm_ordered):1])
plot(svd1$u[,1], 40:1, xlab = "Row", ylab = "First Left Singular Vector", pch=19)
plot(svd1$v[,1], xlab = "Column", ylab = "First Right Singular Vector", pch = 19)

# The SVD can also show how much variance is explained by which dimension.
par(mfrow = c(1,2))
# This is the absolute value in the D matrix. It is hard to interpret because of 
# the scale on the y axis.
plot(svd1$d, xlab = "column", ylab = "Singular Value", pch = 19)
# This plot turns the values into a percent (of total variance).
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Proportion of Variance 
     Explained", pch = 19)

##############################
# Skipping the rest of the SVD and PCA topic. Notes and explanations are not
# explaining it properly and can't find any easy access sources.
#
# Topic seems important for machine learning, so I might have to revisit this.
# Especially for pattern recognition it seems important.

# Alternative/related approaches are:
# Factor Analysis
# Independent Component Analysis
# Latent Semantic Analysis

# The book Elements of statistical learning and the statlearn course on Stanford
# Online go deeper on this topic.