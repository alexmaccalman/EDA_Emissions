library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# extract coal data
coal <- SCC[grep("[Cc]oal", SCC$EI.Sector),]
# merged data
merged <- merge(NEI, coal, by = "SCC")
totals <- merged %>% group_by(year) %>% summarise(total = sum(Emissions))

# plot data
with(totals, plot(year, total/1000, type = "b", pch = 20, xlab = "Year", 
                  ylab = "Total PM2.5 Emissions (1000s)", 
                  main = "Total Annual PM2.5 Emissions by Year Coal Combustion-related Sources"))

dev.copy(png,'plot4.png')
dev.off()