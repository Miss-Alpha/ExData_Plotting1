library(lubridate)
library(dplyr)

#read data
hp_pw <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

#change date format and introduce a new datetime variable
hp_pw$Date <- as.Date(hp_pw$Date, format = "%d/%m/%Y")
hp_pw_2007 <- subset(hp_pw , Date>= "2007-02-01" & Date <= "2007-02-02")
datetime <- as.POSIXct(paste(hp_pw_2007$Date, hp_pw_2007$Time, format = "%d/%m/%Y %H:%M:%S"))
hp_pw_2007 <- mutate(hp_pw_2007, DateTime = datetime)


png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

#topleft
plot(x= hp_pw_2007$DateTime, y=hp_pw_2007$Global_active_power, 
     xlab="", ylab="Global Active Power (kilowatts)", type = "l")

#topright
plot(x = hp_pw_2007$DateTime, y = hp_pw_2007$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

#bottom_left
plot(x= hp_pw_2007$DateTime, y=hp_pw_2007$Sub_metering_1, col = c("black","red", "blue"), 
     xlab="", ylab="Energy sub metering", type = "n")
lines(x= hp_pw_2007$DateTime, hp_pw_2007$Sub_metering_1, col = "black", type = "l")
lines(x= hp_pw_2007$DateTime, hp_pw_2007$Sub_metering_2, col = "red", type = "l")
lines(x= hp_pw_2007$DateTime, hp_pw_2007$Sub_metering_3, col = "blue" , type = "l")
legend("topright", lty = 1, col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#bottom_right
plot(x= hp_pw_2007$DateTime, y=hp_pw_2007$Global_reactive_power, type = "l")

dev.off()
