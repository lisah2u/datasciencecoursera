# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


