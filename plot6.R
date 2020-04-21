library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# extract vehicle data
mv <- SCC[grep("[Vv]ehicle", SCC$EI.Sector),]
# merged data
merged <- merge(NEI, mv, by = "SCC")
# Calaculate totals
baltimore <- merged %>% filter(fips == "24510") %>% group_by(year) %>% summarise(total = sum(Emissions)) %>%
  mutate(County = "Baltimore")
LA <- merged %>% filter(fips == "06037") %>% group_by(year) %>% summarise(total = sum(Emissions)) %>% 
    mutate(County = "Los Angeles")
newDF <- rbind(baltimore, LA)

# plot data
ggplot(newDF, aes(year, total, group = County)) + geom_line(aes(color = County)) +
  geom_point(aes(color = County, size = 1)) +
  labs(x = "Year", y = "Total PM2.5 Emissions", title = "Total Annual PM2.5 Emissions by Year", 
       subtitle = "by Vehicle Related Sources")

dev.copy(png,'plot6.png')
dev.off()