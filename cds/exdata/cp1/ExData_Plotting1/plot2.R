#####    Course Project 1 - Plot 2    #####
###########################################

# Load the data and format it

setwd("C:/Chris/cds/exdata/cp1")
raw <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
           header = TRUE, colClasses = c("character","character", rep("numeric", 7)))

raw$datetime <- as.POSIXct(paste(raw$Date, raw$Time), 
                           format = "%d/%m/%Y %H:%M:%S")

# Change to repo dir
setwd("C:/Chris/cds/exdata/cp1/ExData_Plotting1")

raw_s <- raw[(raw$Date == "1/2/2007" | raw$Date == "2/2/2007"),]

# Plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(x = raw_s$datetime, y = raw_s$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()