#####    Structure of a Data Analysis    #####
##############################################


### Steps in a Data Analysis

# This is a typical list of steps for a data analysis:
#
# 1. Define the question
# 2. Define the ideal data set
# 3. Determine what data you can access
# 4. Obtain the data
# 5. Clean the data
# 6. Exploratory data analysis
# 7. Statistical prediction/modeling
# 8. Interpret results
# 9. Challenge results
# 10. Synthesize/write up results
# 11. Create reproducible code


### 1. Define the Question

# Coming up with a well defined question is one of the most important steps. A
# key benefit of doing this is that you'll be able to focus your research and
# simplify the data you're dealing with.

# A proper data analysis starts with a question, leading to the data, and then
# applying (statistical) methods. Just doing the last two steps puts you in the
# danger zone.


### 2. Define the ideal data set

# Characteristics of the data depend on what your goal is:
#
# Descriptive analysis: A whole population
# Exploratory: Random sample with many variables
# Inferential: The right population, randomly sampled
# Predictive: A training and test data set from the same population
# Causal: Data from a randomized study
# Mechanistic: Data about all components of a system


### Determine What Data You Can Access

# Sometimes data can be found freely on the web. Other times it might have to be
# bought. If the data doesn't exist it might have to be generated first.

# A very good source for free data is the UCI Machine Learning Repository.


### Obtain the Data

# Try to always obtain the raw data.

# Always reference the source. When loading data from the web, always record the
# url and datetime of getting it.


### Clean the Data

# Raw data often needs to be processed first. This can include reformatting or
# subsampling. Always record and document all steps!

# Always understand the source of the data and the way in which it was 
# preprocessed first. 

# Determine if the data is good enough to continue. If it isn't, don't! Just 
# pressing on can lead to wrong inference in the future.


### Exploratory Data Analysis

# Look at summaries of the data and check for missing data/values. Create 
# exploratory plots and perform exploratory analysis like clustering.


### Statistical Prediction/Modeling

# Modeling should be done in an informed way, based on the results of your 
# exploratory analysis. The exact methods used depend on the question.
#
# Transformations of the data should be properly accounted for and measures of
# uncertainty should be reported.


### Interpret Results

# Use the appropriate language so you don't infer to much! 
#
# Explain as much as possible and sensible. Also the coefficients and measures
# of uncertainty should be interpreted.


### Challenge Results

# Challenge all steps: Question, data source, processing, analysis, conclusions.
# Also challenge the measures of uncertainty and the choices of what terms 
# where included/excluded in the analysis. 
#
# Thinking of potential alternative analyses that could be done is also good.


### Synthesize/Write Up Results

# Always lead with the question. In the main part summarize the analyses into a 
# coherent story, This means not including every analysis that was done, but 
# rather only those that are needed for the story and address the challenge. It
# helps to keep all other analyses as backup though. Also the order in which 
# analyses are presented are often not the order in which they were done. They
# should be ordered according to the flow of the story, not chronologically.
# Lastly it is very important to include "pretty" figures in order to facilitate
# understanding.


### Create Reproducible Code

# Do this by intertwining the story with the code, which can be done with a tool
# like knitr.