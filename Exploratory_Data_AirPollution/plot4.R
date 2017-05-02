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

## Q4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
coalRelated <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coalRelated <- SCC[coalRelated, ]
SCC.ids <- as.character(coalRelated$SCC)
NEI$SCC <- as.character(NEI$SCC)
combustionNEI <- NEI[NEI$SCC %in% SCC.ids, ]
emission_coal_related <- aggregate(Emissions ~ year, combustionNEI,sum)

png(filename='plot4.png', width=480, height=480, units='px')
plot(emission_coal_related$year, emission_coal_related$Emissions/1e5, type="o",col="blue",
     xlim=c(1999,2008), ylab="PM2.5 Emissions (x10^5)",xlab="Year", pch=20,
     main="Coal combustion source emissions across US from 1999-2008")
dev.off()

cat("Emissions from coal combustion related sources have decreased from 6E5 to below 4E5 from 1999-2008."
