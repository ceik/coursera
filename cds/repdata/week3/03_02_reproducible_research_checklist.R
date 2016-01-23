#####     Reproducible Research Checklist    #####
##################################################


### Do: Good Science Principles

# 1. Garbage in, garbage out
# 2. Get a focused, coherent question
# 3. Work with good collaborators because it reinforces good practices
# 4. Work on interesting things because it will motivate you.


### Don't: Do Things by Hand

# 1. Editing spreadsheets manually is evil. This includes editing for QA/QC, for 
#    removing outliers, or for validation purposes.
# 2. Editing tables or figures (e.g. rounding, formatting).
# 3. Downloading data from a website via browser.
# 4. Moving data around on the computer or splitting data files by hand.
# 5. "We're just going to do this once": Doesn't matter and often is not true.
#
# Anything done by hand needs to be percisely documented, which is often very
# hard.


### Don't Point and Click

# Data processing / statistical analysis tools that have a GUI are very 
# convenient and easy to use. However they make it very difficult for others to
# reproduce what you did. This problem is partially offset if the program 
# writes a logfile that documents your steps.


### Do: Teach a Computer

# Try to teach the computer all the steps of your analysis, even if they only 
# need to be done once. This ensures reproducibility because the instructions
# need to be very specific.


### Do: Use Some Version Control

# 1. Slow things down.
# 2. Add changes in small chunks instead of massive commits.
# 3. Track snapshots and be able to convert to old versions.
# 4. Be able to use sites like github or bitbucket to publish things.


### Do: Keep Track of Your Environment

# Esp. for large and complex projects the environment can be a critical factor 
# in reproducibility.
#
# 1. Hardware: CPU (manufacturer, 64/32 bit), GPU
# 2. OS
# 3. Software toolchain: Compilers, interpreters, shell, programming language, 
#    database backends, data analysis software
# 4. Supporting software/infrastructure: Libraries, packages, dependencies
# 5. External dependencies: Websites, data repositories, remotes databases, 
#    software repos
# 6. Version numbers for ideally everything.

sessionInfo()
# This gives you quite a bit of the relevant environment details.


### Don't: Save Output

# Avoid saving the output of your analysis (tables, figures, summaries) until 
# the very end. Rather stored data & code only. This way you ensure everything
# is reproducible.
#
# Exceptions are intermediate files that make the analysis more efficient (as 
# long as they are properly documented).


### Do: Set Your Seed

# RNGs generate pseudo random numbers based on a seed (usually a set of numbers).
set.seed(123)
# This function sets the seed in R. This must always be done in order to ensure
# the result is reproducible.


### Do: Think About the Entire Pipeline

# Raw Data -> Processed Data -> Analysis -> Report
# Every step is important and must be reproducible. Not just the analysis/report.