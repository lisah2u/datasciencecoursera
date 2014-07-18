# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? Which have seen 
# increases in emissions from 1999–2008? Use the ggplot2 plotting system to 
# make a plot answer this question.

library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# barplot of four types of emissions per year

as.factor(baltimore$type)
baltimore <- subset(NEI, NEI$fips =="24510")

point <- subset(NEI, NEI$fips == "24510" & type == "POINT")
nonpoint <- subset(NEI, NEI$fips == "24510" & type == "NONPOINT")
onroad <- subset(NEI, NEI$fips == "24510" & type == "ON-ROAD")
nonroad <- subset(NEI, NEI$fips == "24510" & type == "NON-ROAD")

d <- ggplot(baltimore,aes(x=year, y=Emissions))

d + facet_wrap(~ type, nrow=2,ncol=2) +
	geom_point() + geom_smooth(method="lm", col="steelblue") +
	coord_cartesian(ylim=c(0,200)) +
	labs(x=" Year") + 
	labs(y="Point Emissions") + 
	labs(title="Sources of Emissions in Baltimore")

ggsave(filename="plot3.png")
