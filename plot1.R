NEI <- readRDS("summarySCC_PM25.rds")
year_sums <- tapply(NEI$Emissions, NEI$year, sum)
data <- ldply(year_sums)
names(data) <- c('Year', 'Emissions')

png(filename='plot1.png')
barplot(data$Emissions, names.arg = data$Year,
        ylab='Total Emissions in Tons (PM 2.5)', xlab='Year', col='blue')
dev.off()