setwd("~/Coursera_DataAnalysis/course4/week1/project/")
path <- getwd()

library(data.table)
library(lubridate)
library(dplyr)

# Load the read_data file
source('./read_data.R')

sel_subsect_data <- function() {
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
}

sel_subsect_data()

# PNG file with a width of 480 pixels and a height of 480 pixels
png(filename='plot1.png', width=480, height=480, units='px')
hist(subset_PC$Global_active_power, main="Global Active Power", col="red", 
     xlab="Global Active Power (kilowatts)")
dev.off()
