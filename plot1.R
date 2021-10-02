library(lubridate)
#read the data
hp_pw <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

#change the format of date column
hp_pw$Date <- as.Date(hp_pw$Date, format = "%d/%m/%Y")
hp_pw_2007 <- subset(hp_pw , Date>= "2007-02-01" & Date <= "2007-02-02")

#draw and save the plot in png format
png("plot1.png", width=480, height=480)
hist(hp_pw_2007$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
