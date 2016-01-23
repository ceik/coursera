#####    knitr    #####
#######################

### Motivation

# In order to make life easier for both the author and reader it makes sense
# to put both code and text together in one file. This solves many steps when
# trying to piece an analysis back together.
#
# The idea of literate statistical programming is that an article is a stream
# of text and code chunks. Literate programs in general are weaved to produce
# human-readable documents and tangled to produce machine-readable documents.
#
# Literate programming requires a documentation and a programming language.
# knitr uses R and a variety of documentation languages.


### How To Make Work Reproducible?

# 1. Decide to do it!
# 2. Keep track of things, e.g. with a version control system like Git.
# 3. Use software whose operations can be coded. This means no GUI because you
#    won't be able to fully backtrack what you did later on.
# 4. Don't save (temporary) output. Rather store the raw data and the processing
#    code.
# 5. Don't use proprietary formats to save data.


### Literate Programming: Pros & Cons

# Pros: 1. Text and code are in one place and in proper logial order.
#       2. Data & results are automatically updated with changes.
#       3. Code is live and will be run when document is created.
#
# Cons: 1. Having text and code in one place can make the document hard to read,
#          especially if there is a lot of code.
#       2. The processing of the document can get slow if they grows very big, 
#          which will slow down the research process.


### What is knitr?

# Its a package that is prebuilt into R. knitr supports RMarkdown, LaTeX, and 
# HTML as documentation languages and can export to HTML or PDF.
#
# knitr will take a document written in RMarkdown (in our case) and first 
# convert it to normal Markdown. Afterwards it will convert it to HTML or 
# another output format.
#
# It is very good for:
# - Manuals
# - Short-/medium-length technical documents
# - Tutorials
# - Reports (esp. if generated periodically)
# - Data processing documents/summaries
#
# It is not good for:
# - Very long research articles (because if they include code they can get very
#   long and thereby confusing to edit)
# - Articles with complex, time-consuming computations (will take very long to 
#   process the document after every change)
# - Documents that require percise formatting


### knitr Without RStudio

# Firstly load library(knitr) and setwd(<working dir>). Afterwards 
# knit2html("document.Rmd") will create the document while 
# browseRUL("document.html") opens it.