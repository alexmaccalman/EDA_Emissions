library(dplyr)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#summarize data
totals <- NEI %>% group_by(year) %>% summarise(total = sum(Emissions))
#create graphic devise
png("plot1.png")
#plot data
with(totals, plot(year, total/1000, type = "b", pch = 20, xlab = "Year", 
                  ylab = "Total PM2.5 Emissions (1000s)", 
                  main = "Total Annual PM2.5 Emissions by Year"))
dev.off()