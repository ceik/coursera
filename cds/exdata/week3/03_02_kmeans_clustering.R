#####    K-Means Clustering    #####
####################################

### Clustering Basic Questions

# How do we define close?
# For continuous variables: Euclidean distance of correlation similarity
# For binary variables: Manhattan distance.
# See Lecture slides on hierachical clustering for details on these methods.
#
# How do we group things?
# How do we visualize the grouping?
# How do we interpret the grouping?


### K-Means Clustering

# This approach uses as fixed number of clusters. For each cluster it get the
# centroid and assigns all observations to one of these clusters.
# The inputs are a number of clusters, the defined distance metric, and an 
# initial guess for the cluster centrois. 
# Assigning all observations to the clusters and defining them is an iterative
# process. It is displayed in the slides to this lecture for the following data.

set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)
plot(x,y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))


### The kmeans() Function

# The kmeans() function implements the k-means algorithm.

df <- data.frame(x, y)
kmeans_obj <- kmeans(df, centers = 3)
names(kmeans_obj)
kmeans_obj
kmeans_obj$cluster
kmeans_obj$centers

par(mar = c(1,1,1,1))
plot(x,y, col = kmeans_obj$cluster, pch = 19, cex = 2)
points(kmeans_obj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)


### Heatmap for K-Means Clustering

set.seed(1234)
dm <- as.matrix(df) [sample(1:12),]
dm
kmeans_obj2 <- kmeans(dm, centers = 3)
par(mfrow = c(1,2), mar = c(2,4,0.1,0.1))
t(dm)
t(dm) [, nrow(dm):1]
image(t(dm) [, nrow(dm):1], yaxt = "n")
image(t(dm) [, order(kmeans_obj$cluster)], yaxt = "n")


### Notes and More Information

# The number of clusters can be picked by eye/intuition. Alternatively cross-
# validation or information theory can be used to determine the number of 
# clusters. Wikipedia has a good article on this:
# http://en.wikipedia.org/wiki/Determining_the_number_of_clusters_in_a_data_set

# THe k-means algo is not deterministic: Depending on how it is implemented the
# results could be different. Different numbers of clusters or iterations are
# possible.

# Video on clustering and distances: https://www.youtube.com/watch?v=wQhVWUcXM0A
#
# Elements of Statistical Learning book: 
# Available here: http://statweb.stanford.edu/~tibs/ElemStatLearn/