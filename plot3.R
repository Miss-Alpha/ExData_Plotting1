library(lubridate)
library(dplyr)

#read the data:
hp_pw <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

#change the date format and introduce a new datetime variable
hp_pw$Date <- as.Date(hp_pw$Date, format = "%d/%m/%Y")
hp_pw_2007 <- subset(hp_pw , Date>= "2007-02-01" & Date <= "2007-02-02")
datetime <- as.POSIXct(paste(hp_pw_2007$Date, hp_pw_2007$Time, format = "%d/%m/%Y %H:%M:%S"))
hp_pw_2007 <- mutate(hp_pw_2007, DateTime = datetime)

#draw and save the plot in png format
png("plot3.png", width=480, height=480)

plot(x= hp_pw_2007$DateTime, y=hp_pw_2007$Sub_metering_1, col = c("black","red", "blue"), 
     xlab="", ylab="Energy sub metering", type = "n")
lines(x= hp_pw_2007$DateTime, hp_pw_2007$Sub_metering_1, col = "black", type = "l")
lines(x= hp_pw_2007$DateTime, hp_pw_2007$Sub_metering_2, col = "red", type = "l")
lines(x= hp_pw_2007$DateTime, hp_pw_2007$Sub_metering_3, col = "blue" , type = "l")
legend("topright", lty = 1, col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
