# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
df <- merge(NEI, SCC, all.x=TRUE)

baltimore <- subset(df, df$fips =="24510")
baltimore.emissions <- tapply(baltimore$Emissions, baltimore$year, sum)
vehicles <- subset(baltimore, grepl("Veh",Short.Name))
vehicles.emissions <- tapply(vehicles$Emissions, vehicles$year, sum)
other <- subset(baltimore, !grepl("Veh",Short.Name))
other.emissions <- tapply(other$Emissions, other$year, sum)

	
d <- ggplot(baltimore,aes(x=year, y=Emissions))

d + 
	geom_point() + geom_smooth(method="lm", col="steelblue") +
	#coord_cartesian(ylim=c(0,200)) +
	labs(x=" Year") + 
	labs(y="Emissions") + 
	labs(title="Motor Vehicle Emissions in Baltimore")

ggsave(filename="plot3.png")
