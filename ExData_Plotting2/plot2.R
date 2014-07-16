# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
# system to make a plot answering this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot emissions per year
png("plot2.png")

baltimore <- subset(NEI, NEI$fips == "24510")
emissions <- tapply(baltimore$Emissions, baltimore$year, sum)
plot(emissions, type="b", pch=16, xlab="Year", ylab="PM2.5 Emissions", main="PM2.5 Emissions in Baltimore from 1999 to 2008", xaxt="n")

# adjust x-axis to display years
axis(1, at=1:4, labels=unique(NEI$year))

dev.off()