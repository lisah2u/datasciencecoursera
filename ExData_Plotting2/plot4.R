# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
df <- merge(NEI, SCC, all.x=TRUE)

coal <- subset(df, grepl("Coal",EI.Sector))
coal.aggregate <- aggregate(Emissions ~ year, data=coal, FUN=mean)

d <- ggplot(coal.aggregate,aes(x=factor(year), y=Emissions))

d + 
	geom_bar(stat="identity") + 
	labs(x=" Year") + 
	labs(y="Emissions") + 
	labs(title="Coal Emissions")

ggsave(filename="plot4.png")

