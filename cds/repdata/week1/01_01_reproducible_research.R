#####    Reproducible Research: Concepts & Ideas    #####
#########################################################


### Replication

# Replication of findings and conducting studies with independent researchers, 
# data, analytical methods, labs, and instruments is the gold standard in 
# science. It is especially important for studies with big impact. However some
# studies can not be replicated because of time/money constraints or because 
# they were based upon a unique situation.
#
# Reproducible research is the idea of making data and code available so that
# others may reproduce the findings. Because analysis is based on data & code 
# this will at least allow others to confirm that it is correct with regards to
# the methods used and descisions made. It's not as good as full and independent 
# replication but much better than nothing. 


### What should be made available?

# 1. Analytic data: Often the raw data might be interesting, but not helpful or
#                   unpractical (e.g. because only a fraction of it was used).
# 2. Analytic code
# 3. Documentation of code and data
# 4. Need for standard means of distribution


### Challenges

# Authors must undertake considerable effort to make things available. Also
# also readers must spend a lot of time getting things and putting them back
# together, while they might not have the same resources available as the 
# original researcher. The toolbox for making this easier is growing though.


### Literate (Statistical) Programming

# The idea is that an article is a stream of text and code. The text should be
# human-readable and tangled into code that produces an outcome.


### Tools Available

# Sweave is a package maintained by the R core team. It uses LaTeX for the 
# documentation and R for programming.
# However Sweave has some inportant limitations: LaTeX is not very popular, it 
# lacks features like caching, multiple plots per code chunk, mixing programming
# languages, and many more. Also it is not actively developed anymore.

# knitr has become very popular recently. It addresses many of Sweaves 
# limitations. It also uses R for programming (while others are allowed) and a
# variety of documentation languages (LaTeX, HTML, Markdown).