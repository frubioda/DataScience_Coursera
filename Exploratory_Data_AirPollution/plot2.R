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

## Q2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.
Baltimore_NEI <- NEI[NEI$fips=="24510",]
total_emissions_Baltimore <- aggregate(Emissions ~ year, Baltimore_NEI,sum)

# PNG file with a width of 480 pixels and a height of 480 pixels
png(filename='plot2.png', width=480, height=480, units='px')
plot(total_emissions_Baltimore$year, total_emissions_Baltimore$Emissions, type="o",
     pch=20, col="blue", ylab="PM2.5 Emissions", xlab="Year", main="Total PM2.5 emission from all Baltimore city sources")
dev.off()

cat("Overall the PM2.5 total emissions have decreased in Baltimore from 1999 to 2008; however there was an increase between 2002 and 2006.")
