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

## Generating Plot 1
png(filename = './figures/plot1.png', width = 480, height = 480, units = 'px')
hist(EXP_Data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

