setwd("~/job_interviews/Coursera_DataAnalysis/course4/week4/project/")
path <- getwd()
library(base)
library(plyr)

# Uncompress zip file
if (file.exists("summarySCC_PM25.rds") == FALSE) {
  unzip("exdata_data_NEI_data.zip")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cat("End of file reading ...")

## Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
total_emissions <- aggregate(Emissions ~ year, NEI, sum)

# PNG file with a width of 480 pixels and a height of 480 pixels
png(filename='plot1.png', width=480, height=480, units='px')
plot(total_emissions$year, total_emissions$Emissions/1e6, type="o", pch=20, col="blue",
     ylab="PM2.5 Emissions (x10^6)", xlab="Year", main="Total PM2.5 emission from all sources")
dev.off()

cat("The total emissions from PM2.5 have decreased in the US from 1999 to 2008")
