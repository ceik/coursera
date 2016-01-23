#####    Reading from Other Sources    #####
############################################

### Find the Relevant Package

# Search for "data storage mechanism R package" and it will come up with a
# relevant package for pretty much all data types.


### Connecting to Files and Interacting with them

# Open connection to text file:
file()
# Open connection to URL:
url()
# Open connection to .gz file:
gzfile()
# Open connection to .bz2 file:
bzfile()
# More info about connections:
?connection
# Always close connections when done!


### Reading from Other Stats Languages/Software

# The foreign package allows doing this. It can read files from Weka, Stata,
# Minitab, Octave, S, SPSS, SAS, Systat.


### Other Database Packages

# RPostgreSQL allows connections to PostgreSQL databases
# RMongo allows connections to MongoDB databases
# RODBC allows connections to multiple different databases, incl Postgres,
# MySQL, MS Access, SQLite


### Reading Images

# Packages are available e.g. for jpeg, png, bitmap, EBImage


### Reading GIS Data

# GIS: Geographic Information System
# Example packages available: rdgal, rgeos, raster


### Reading Music Data

# Example packages: tuneR, seewave