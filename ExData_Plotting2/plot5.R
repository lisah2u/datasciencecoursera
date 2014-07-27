# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
df <- merge(NEI, SCC, all.x=TRUE)

baltimore <- subset(df, df$fips =="24510")
vehicles <- subset(baltimore, grepl("Veh",Short.Name))
vehicles.emissions <- aggregate(Emissions ~ year, data=vehicles, FUN=mean)

d <- ggplot(vehicles.emissions,aes(x=factor(year), y=Emissions))

d + 
	geom_bar(stat="identity") + 
	labs(x=" Year") + 
	labs(y="Emissions") + 
	labs(title="Motor Vehicle Emissions in Baltimore")

ggsave(filename="plot5.png")
