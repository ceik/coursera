#####    Reading Data from MySQL    #####
#########################################

### Working on a MySQL Database with the RMySQL Package

library(RMySQL)

# Connecting and listing databases. Example DB used is one on the human genome
# hosted by the University of California Santa Cruz (http://genome.ucsc.edu).
ucscDB <- dbConnect(MySQL(), user="genome", 
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDB, "show databases")
result

# It is vital to always disconnect from the database after sending it a query!
dbDisconnect(ucscDB)

# Connect to the database again, but this time to a specific database within it.
hg19 <- dbConnect(MySQL(), user="genome", db = "hg19",
                    host="genome-mysql.cse.ucsc.edu")
# Listing the tables in the database and storing them in a variable.
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

# Get columns of a specific table.
dbListFields(hg19, "affyU133Plus2")

# Get number of rows of a specific table.
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
dbDisconnect(hg19)

# Reading a table into a datafram.
affyData <- dbReadTable(hg19, "affyU133Plus2")
dbDisconnect(hg19)

# Sending a query to the server without directly fetching the result. The fetch
# function needs to be used afterwards to retrieve the result of the query. Once
# done it is very important to clear the query on the server, otherwise it will
# hang around forever.
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n = 10)
dim(affyMisSmall)
dbClearResult(query)
dbDisconnect(hg19)


### Further Resources

# RMySQL vignette: http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
# r-bloggers: http://www.r-bloggers.com/mysql-and-r/
















