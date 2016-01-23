#####    Course Project 1 - Plot 4    #####
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

# Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(x = raw_s$datetime, y = raw_s$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")
plot(x = raw_s$datetime, y = raw_s$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")
with(raw_s, plot(raw_s$datetime, raw_s$Sub_metering_1, type = "n", xlab = "", 
                 ylab = "Energy sub metering"))
with(raw_s, lines(raw_s$datetime, raw_s$Sub_metering_1, col = "black"))
with(raw_s, lines(raw_s$datetime, raw_s$Sub_metering_2, col = "red"))
with(raw_s, lines(raw_s$datetime, raw_s$Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(x = raw_s$datetime, y = raw_s$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")
dev.off()