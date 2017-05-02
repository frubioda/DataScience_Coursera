setwd("~/job_interviews/Coursera_DataAnalysis/course4/week4/project/")
path <- getwd()
library(plyr)
library(ggplot2)

# Uncompress zip file
if (file.exists("summarySCC_PM25.rds") == FALSE) {
  unzip("exdata_data_NEI_data.zip")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cat("End of file reading ...")


## Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

vehicles_SCC <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
vehicles_SCC <- SCC[vehicles_SCC, ]
SCC.ids <- as.character(vehicles_SCC$SCC)
NEI$SCC <- as.character(NEI$SCC)
vehicles_NEI <- NEI[NEI$SCC %in% SCC.ids, ]
Baltimore_Vehicles_NEI <- vehicles_NEI[which(vehicles_NEI$fips == "24510"), ]
LA_Vehicles_NEI <- vehicles_NEI[which(vehicles_NEI$fips == "06037"), ]
emission_vehicles_Baltimore <- aggregate(Emissions ~ year, Baltimore_Vehicles_NEI, sum)
emission_vehicles_LA <- aggregate(Emissions ~ year, LA_Vehicles_NEI, sum)

emission_vehicles_Baltimore$group <- rep("Baltimore County", length(emission_vehicles_Baltimore[, 1]))
emission_vehicles_LA$group <- rep("Los Angeles County", length(emission_vehicles_LA[, 1]))
emission_vehicles_LA_Baltimore <- rbind(emission_vehicles_LA, emission_vehicles_Baltimore)

png(filename='plot6.png', width=500, height=380, units='px')
qplot(year, Emissions, data=emission_vehicles_LA_Baltimore, group=group, color=group, 
      geom=c("point","line"), ylab="PM2.5 Emissions", xlab="Year",
      main="Motor vehicle source emissions in Baltimore & LA, 1999-2008")
dev.off()

cat("LA has seen the greatest changes over time in motor vehicle emissions.")
