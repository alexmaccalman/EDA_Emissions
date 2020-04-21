library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#summarize data
county <- NEI %>% filter(fips == "24510")
Bal <- county %>% group_by(year, type) %>% summarise(total = sum(Emissions))

#plot data
ggplot(Bal, aes(year, total)) +geom_point() + facet_grid(.~type) + labs(x = "Year", 
              y = "Total PM2.5 Emissions", title = "Total Annual PM2.5 Emissions by Type", 
              subtitle = "Baltimore")

dev.copy(png,'plot3.png', width = 800, hieght = 480)
dev.off()