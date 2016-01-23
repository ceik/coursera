#####    Markdown    #####
##########################

### What Is Markdown?

# Markdown is a text-to-HTML conversion tool for web writers. It allows you to
# write using an easy-to-read, easy-to-write plain text format and then convert
# it to structurally valid (X)HTML.
#
# It is a simplier version of markup languages that allows the writer to focus 
# on the actual text as opposed to the formatting. 


### Basic Markdown Syntax

# *Single asterisk denotes italics*
# **Double asterisk denotes bold**
# # Primary Heading
# ## Secondary Heading
# ### Tertiary Heading
# #### ...


### Lists

# Unordered lists can be created with many characters as long as the same 
# character is used for the entire list. E.g.:
# - One item
# - Another item

# Ordered lists can be created with any number. The actual number doesn't matter
# very much as long as the whole list is made up of numbers. For example another
# item can be inserted later in the middle of the list without having to rename 
# all items in the list. Markdown will automatically convert it correctly.
# 1. one item
# 2. and another one


### Links

# First way: [text] (url)
# [RStudio] (http://www.rstudio.com/)

# The second way makes is a bit easier to integrate links into a text flow, by
# allowing you to put the actual link at the end of the text.
# E.g.:
# I spend so much time reading [R bloggers][1] and [Simply Statistics][2]!
#    [1]: http://www.r-bloggers.com/ "R bloggers"
#    [2]: http://simplystatistics.org/ "Simply Statistics"


### Newlines

# In order to get a new line, a line has to be ended with two spaces "  ".
# Otherwise markdown will put the text of two lines into one (if it fits).