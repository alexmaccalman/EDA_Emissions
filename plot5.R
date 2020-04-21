library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# extract vehicle data
mv <- SCC[grep("[Vv]ehicle", SCC$EI.Sector),]
# merged data
merged <- merge(NEI, mv, by = "SCC")
# Find totals in Balitmore
baltotals <- merged %>% filter(fips == "24510") %>% group_by(year) %>% summarise(total = sum(Emissions))


# plot data
ggplot(baltotals, aes(year, total)) + geom_area(fill = "red", alpha = 0.2) +
  geom_line(color = "red", size = 1) +  
  geom_point(size = 4, color= "red") +
  labs(x = "Year", y = "Total PM2.5 Emissions", 
       title = "Total Annual PM2.5 Emissions by Year", subtitle = "Vehicle-realted Sources in Baltimore")

dev.copy(png,"plot5.png")
dev.off()