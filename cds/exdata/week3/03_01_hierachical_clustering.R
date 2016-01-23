#####    Hierachical Clustering    #####
########################################

### Clustering Basics

# Clustering organizes things that are close togheter into groups. Key questions
# in this process are:
# 1. How do we define close?
# 2. How does the grouping happen?
# 3. How do we visualize the grouping?
# 4. How do we interpret the grouping?


### Agglomerative Approach

# Popular approach for hierachical clustering. It is the bottom-up approach to 
# hierachical clustering. It looks for the two closest things, puts them 
# together, finds the next closest one, adds it, etc.
#
# This requires two things: A measure to define the "distance" between two 
# observations, and a way to merge two observations.
#
# The outcome can be visualized in a tree diagram (dendrogram).
#
# Distance measures:
# 1. Euclidian distance for continuous variables. This is the "straight line" 
#    distance.
# 2. Correlation similarity for continuous variables. 
# 3. Manhattan distance for binary variables.
#
# See slides for how to calculate euclidian and manhattan distance.


### Hierachical Clustering Example

set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)
plot(x,y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# 1st Step: Calculate the distances between all points. This can be done with 
#           the dist() function. By default it calculates the euclidian distance.
#           It takes a dataframe as an input and returns a matrix of distances.

df <- data.frame(x=x, y=y)
df
dist(df)

distxy <- dist(df)
hClustering <- hclust(distxy)
hClustering
plot(hClustering)

# Plotting the output of the hclust() function returns a dendrogram. This shows
# which points were combined and in what order. It does not by itself show how
# many clusters there are because this is not decided by the hclust() function.
# You need to decide where to "cut the tree". E.g. cutting it at 1.0 results in
# three clusters, while cutting it at 2.0 results in two.


### Merging Points

# When merging two points, you need to determine what represents its new 
# location. There are two methods to do this:
#
# 1. Average Linkage: New coordinates of the merged points is the average of the
#                     coordinates of the two original points.
# 2. Complete Linkage: Take the two points that are farthest from each other and
#                      use their distance.


### The heatmap() Function

# The heatmap function is an easy way to visualize clusters of data.
df <- data.frame(x=x, y=y)
set.seed(143)
data_matrix <- as.matrix(df) [sample(1:12),]
heatmap(data_matrix)
data_matrix
data_matrix[1,x]
df


### Notes and Further Information

# The picture given by clustering might be unstable and very sensitive (e.g. 
# with regards to a few points, missing values, picked methods). Often it is 
# prudent to try different methods to become aware of this.
#
# Scaling is another aspect that can throw off the algorithm. If for example
# different values are measured on very different scales this can become a
# problem.
#
# Choosing where to cut is an important aspect but it is not always obvious.

# Video on clustering and distances: https://www.youtube.com/watch?v=wQhVWUcXM0A
#
# Elements of Statistical Learning book: 
# Available here: http://statweb.stanford.edu/~tibs/ElemStatLearn/