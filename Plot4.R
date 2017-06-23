#setwd()
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./Data/household_power_consumption.zip"
householdFile <- "./Data/household_power_consumption.txt"
##
if (!file.exists(householdFile)) {
  download.file(downloadURL, downloadFile)
  unzip(downloadFile, overwrite = T, exdir = "./Data")
}

rawData <- read.table(householdFile, header = T, sep = ";", na.strings = "?")
## set time variable
EXP_Data <- rawData[rawData$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <- strptime(paste(EXP_Data$Date, EXP_Data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
EXP_Data <- cbind(SetTime, EXP_Data)

## Generating Plot 4
png(filename = './figures/plot4.png', width = 480, height = 480, units = 'px')
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow = c(2,2))
plot(EXP_Data$SetTime, EXP_Data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(EXP_Data$SetTime, EXP_Data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(EXP_Data$SetTime, EXP_Data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(EXP_Data$SetTime, EXP_Data$Sub_metering_2, type = "l", col = "red")
lines(EXP_Data$SetTime, EXP_Data$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty="n", legend = labels, lty = 1, col = columnlines)
plot(EXP_Data$SetTime, EXP_Data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
