## Load library dplyr.
library(dplyr)

## Read the subset of data only contains 2007-02-01 and 2007-02-02, then give the subset of data variable names.
file <- "household_power_consumption.txt"
datasub <- read.table(text = grep("^[1,2]/2/2007", readLines(file), value = TRUE), sep = ";", na.strings = "?")
colnames(datasub) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Change date and time to the Date/Time classes using strptime() function. 
DateTime <- paste(datasub$Date, datasub$Time)
datasub$DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")

## Plot three sub metering on a same plot agianst DateTime with a legend. 
with(datasub, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black"))
points(datasub$DateTime, datasub$Sub_metering_2, type = "l", col = "red")
points(datasub$DateTime, datasub$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7)