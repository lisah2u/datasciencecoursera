# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years 
# 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join on SCC code
#df <- merge(NEI, SCC, all.x=TRUE)

# plot emissions per year
emissions <- tapply(NEI$Emissions, NEI$year, sum)
plot(emissions, type="b", xlab="Year", ylab="PM2.5 Emissions")

# adjust x-axis to display years
axis(1, NEI$year)
