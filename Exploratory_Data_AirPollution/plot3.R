setwd("~/job_interviews/Coursera_DataAnalysis/course4/week4/project/")
path <- getwd()
library(ggplot2)
library(plyr)

# Uncompress zip file
if (file.exists("summarySCC_PM25.rds") == FALSE) {
  unzip("exdata_data_NEI_data.zip")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cat("End of file reading ...")

## Q3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.
Baltimore_NEI <- NEI[NEI$fips=="24510",]
#aggregate emissions by year, county, type and filter “24510”
total_emissions_Baltimore_type <- ddply(Baltimore_NEI, .(type, year), summarize, Emissions=sum(Emissions))
total_emissions_Baltimore_type$Pollutant_Type <- total_emissions_Baltimore_type$type

# PNG file
png(filename='plot3.png', width=500, height=380, units='px')
qplot(year, Emissions, data=total_emissions_Baltimore_type, group=Pollutant_Type,
      color=Pollutant_Type, geom = c("point", "line"), ylab = expression("PM2.5 Emissions"),
      xlab = "Year", main = "Total PM2.5 emission from Baltimore, by Type of Pollutant")
dev.off()

cat("The source types non-road, nonpoint, on-road have seen decreases in emissions from 1999-2008 in Baltimore City.")
cat("The point source have seen a slight increase from 1999-2008.")
