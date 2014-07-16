# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years 
# 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot emissions per year
png("plot1.png")

emissions <- tapply(NEI$Emissions, NEI$year, sum)
#plot(emissions, pch=16, xlab="Year", ylab="PM2.5 Emissions", main="PM2.5 Emissions in the US from 1999 to 2008", xaxt="n")
plot(emissions, type="b", pch=16, xlab="Year", ylab="PM2.5 Emissions", main="PM2.5 Emissions in the US from 1999 to 2008", xaxt="n")

# adjust x-axis to display years
axis(1, at=1:4, labels=unique(NEI$year))

dev.off()