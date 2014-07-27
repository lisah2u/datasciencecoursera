# Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). Which city has seen greater changes over 
# time in motor vehicle emissions?

library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
df <- merge(NEI, SCC, all.x=TRUE)

baltimore.emissions <- subset(df, df$fips =="24510")
losangles.emissions <- subset(df, df$ fips == "06037")
vehicles.baltimore <- subset(baltimore.emissions, grepl("Veh",Short.Name))
vehicles.losangles <- subset(losangles.emissions, grepl("Veh",Short.Name))

baltimore.emissions <- aggregate(Emissions ~ year, data=vehicles.baltimore, FUN=mean)
losangles.emissions <- aggregate(Emissions ~ year, data=vehicles.losangles, FUN=mean)
baltimore.emissions$county <- "Baltimore"
losangles.emissions$county <- "Los Angeles County"
counties <- rbind(baltimore.emissions, losangles.emissions)
counties$year <- factor(counties$year)

d <- ggplot(counties,aes(x=year, y=Emissions, fill=county))

d + 
	geom_bar(stat="identity") +
	facet_grid(county  ~ ., scales="free") +
	labs(x=" Year") + 
	labs(y="Motor Vehicle Emissions") + 
	labs(title="Motor Vehicle Emissions \n in Baltimore and Los Angeles")

ggsave(filename="plot6.png")