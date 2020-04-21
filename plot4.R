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

ggplot(totals, aes(year, total/1000)) + geom_area(fill = "green", alpha = 0.2) +
  geom_line(color = "green", size = 1) +  
  geom_point(size = 4, color= "green") +
  labs(x = "Year", y = "Total PM2.5 Emissions (1000s)", 
       title = "Total Annual PM2.5 Emissions by Year", subtitle = "Coal Combustion-Realted Sources in Baltimore")

dev.copy(png,"plot4.png")
dev.off()