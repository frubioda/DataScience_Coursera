setwd("~/job_interviews/Coursera_DataAnalysis/course4/week4/project/")
path <- getwd()
library(plyr)
library(base)

# Uncompress zip file
if (file.exists("summarySCC_PM25.rds") == FALSE) {
  unzip("exdata_data_NEI_data.zip")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cat("End of file reading ...")


## Q5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
vehicles_SCC <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
vehicles_SCC <- SCC[vehicles_SCC, ]
SCC.ids <- as.character(vehicles_SCC$SCC)
NEI$SCC <- as.character(NEI$SCC)
vehicles_NEI <- NEI[NEI$SCC %in% SCC.ids, ]
Baltimore_Vehicles_NEI <- vehicles_NEI[which(vehicles_NEI$fips == "24510"), ]
emission_vehicles_Baltimore <- aggregate(Emissions ~ year, Baltimore_Vehicles_NEI, sum)

png(filename='plot5.png', width=480, height=480, units='px')
plot(emission_vehicles_Baltimore$year, emission_vehicles_Baltimore$Emissions, type="o", col="blue",
     pch=20, ylab="PM2.5 Emissions", xlab="Year", main="Motor vehicle source emissions in Baltimore from 1999-2008")
dev.off()

cat("Emissions from motor vehicle sources have increased in 2002 and decreased from 2002-2008 in Baltimore")
