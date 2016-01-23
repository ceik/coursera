#####    Reading from HDF5    #####
###################################

### Info on HDF5

# Hierarchical data format that is used to store large datasets and supports a
# range of data types. It is organized in groups containing zero or more
# datasets and metadata. 
# 
# Each group has a group header with a group name and
# a list of attributes. Also each group has a group symbol table with a list
# of objects in the group.
#
# Datasets are multidimensional arrays of data elements with metadata. They
# have a header with name, datatype, dataspace, and storage layout as well as
# a data array with the data.
#
# For more info on HDF5 check http://www.hdfgroup.org/
# Lecture is based on: 
# http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf


### Get the HDF5 Package and Create a File

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)

created = h5createFile("example.h5")
created


### Create, Write, and Read to Groups in HDF5

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

A = matrix(1:10, nr = 5, nc = 2)
h5write(A, "example.h5", "foo/A")

B = array(seq(0.1, 2.0, by = 0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")

df = data.frame(1L:5L, seq(0,1, length.out = 5),
                c("ab", "cde", "fghi", "a", "s"), stringsAsFactors=F)
h5write(df, "example.h5", "df")

h5ls("example.h5")

readA = h5read("example.h5", "foo/A")
readA

### Writing and Reading in Chuncks

# The index parameter is specified for each dimension, e.g. (rows, cols)
h5write(c(12,13,14), "example.h5", "foo/A", index = list(1:3,1))
h5read("example.h5", "foo/A")
h5read("example.h5", "foo/A",  index = list(1:3,1))













