library(lubridate)
library(dplyr)

#read data:
hp_pw <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

#change the date format and introduce a new datetime variable
hp_pw$Date <- as.Date(hp_pw$Date, format = "%d/%m/%Y")
hp_pw_2007 <- subset(hp_pw , Date>= "2007-02-01" & Date <= "2007-02-02")
datetime <- as.POSIXct(paste(hp_pw_2007$Date, hp_pw_2007$Time, format = "%d/%m/%Y %H:%M:%S"))
hp_pw_2007 <- mutate(hp_pw_2007, DateTime = datetime)

#draw and save the plot
png("plot2.png", width=480, height=480)
plot(x= hp_pw_2007$DateTime, y=hp_pw_2007$Global_active_power, 
     xlab="", ylab="Global Active Power (kilowatts)", type = "l")
dev.off()
