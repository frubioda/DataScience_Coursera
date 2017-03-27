setwd("~/Coursera_DataAnalysis/course4/week1/project/")
path <- getwd()

library(data.table)
library(lubridate)
library(dplyr)

#sel_subset_data <- function() {
  # Read data
  power_consuption <- read.table("./household_power_consumption.txt", header=TRUE, 
                                 sep=';',na.strings='?')
  # Rearrange Date and Time formats:
  power_consuption$Date <- as.Date(power_consuption$Date, '%d/%m/%Y')
  power_consuption$Time <- as.POSIXct(strptime(paste(power_consuption$Date, ' ', 
                                                     power_consuption$Time), '%Y-%m-%d %H:%M:%S'))
  # Select subset power consuption: 2-day period in February, 2007
  subset_PC <- power_consuption[power_consuption$Date == ymd(20070201) | power_consuption$Date == ymd(20070202), ]
  subset_PC
  cat("End of file reading and subsetting; output is subset_PC ...")
#}
#sel_subset_data()


# PNG file with a width of 480 pixels and a height of 480 pixels
png(filename='plot3.png', width=480, height=480, units='px')
datetime <- strptime(paste(subset_PC$Date, ' ', subset_PC$Time), '%Y-%m-%d %H:%M:%S') 

plot(subset_PC$Time, subset_PC$Sub_metering_1, type="l", ylab="Energy Submetering", xlab=' ')
lines(subset_PC$Time, subset_PC$Sub_metering_2, type="l", col="red")
lines(subset_PC$Time, subset_PC$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()
