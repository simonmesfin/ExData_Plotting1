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

## Generating Plot 3
png(filename = './figures/plot3.png', width = 480, height = 480, units = 'px')
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(EXP_Data$SetTime, EXP_Data$Sub_metering_1, type = "l", col = columnlines[1], xlab = "", ylab = "Energy sub metering")
lines(EXP_Data$SetTime, EXP_Data$Sub_metering_2, col = columnlines[2])
lines(EXP_Data$SetTime, EXP_Data$Sub_metering_3, col = columnlines[3])
legend("topright", legend = labels, col = columnlines, lty = "solid")
dev.off()
