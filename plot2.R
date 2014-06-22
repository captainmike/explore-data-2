NEI <- readRDS("summarySCC_PM25.rds")
baltimore_pm25 <- NEI[NEI$fips==24510,]
year_sums <- tapply(baltimore_pm25$Emissions, baltimore_pm25$year, sum)
data <- ldply(year_sums)
names(data) <- c('Year', 'Emissions')

png(filename='plot2.png')
barplot(data$Emissions, names.arg = data$Year,
        ylab='Total Emissions in Tons (PM 2.5) in Baltimore, Maryland', xlab='Year', col='blue')
dev.off()