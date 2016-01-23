#####    Organizing a Data Analysis    #####
############################################

### Data Analysis Files

# There will be different kinds of files involved:
#
# Data Files: Can be raw or processed
# Figures: Exploratory figures and final (polished) ones
# (R) Code Files: Unused, used, and final scripts as well as R markdown files
# Text Files: Readme file and final report


### Raw Data Files

# They should be stored in the analysis folder. Also the source, description, 
# and datetime it was accessed should be recorded somewhere. This can be done 
# in for example a readme or in the git log.


### Processed Data Files

# These files should be named so that it is easy to see which script generated
# them. Also the mapping of script to processed data file should be documented,
# for example in the readme. Processed data should be tidy!


### Exploratory Figures

# These aren't necessarily part of the final report but should still be stored.
# They don't need to be pretty but understandable enough and reproducible.
# Exploratory figures often have less dimensions that final ones.


### Final Figures

# These are polished and there are way less final than exploratory ones. A 
# typical paper has 4-5. Coloring and multiple panels are often an important 
# factor. They need to be properly documented and stored.


### Raw Scripts

# Can be less commented and if they aren't used they can be discarded at some 
# point if they aren't helpful anymore. 


### Final Scripts

# Need to be clearly commented: Bigger blocks for whole sections, smaller 
# comments for the what, when, why, how inbetween. Any code that is used on the 
# end needs to be included here (incl. data processing code). Make sure this 
# link between report and code is clear (what was used when).


### R Markdown Files

# These can be used to create reproducible reports easily because code and text
# can be integrated nicely. Store them properly


### Readme Files

# Should document the step-by-step of the analysis. They are not necessary if
# code is well documented or R markdown is used. 


### Final Report

# Should have a title, intro (motivation), methods used (incl. references for 
# statistical methods that were used), results (incl. measures of uncertainty),
# and conclusions (incl. potential problems and pitfalls).
# The final report should tell a coherent story and should only contain the 
# relevant analyses.


### Further Resources

# Article on managing statistical projects and best practices:
# http://www.r-statistics.com/2010/09/managing-a-statistical-analysis-project-guidelines-and-best-practices/
#
# The projecttemplate package can help to automate many things:
# http://projecttemplate.net/