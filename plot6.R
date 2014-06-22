library(ggplot2)
library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

FIP_LOOKUP <- data.frame(city=c('Baltimore', 'Los Angeles County'),
                         fips=c('24510', '06037'))

motor_scc <- SCC[grepl('motor', SCC[['Short.Name']], ignore.case = TRUE, perl = TRUE), ]
motor_nei <- NEI[NEI$SCC %in% motor_scc$SCC & NEI$fips %in% FIP_LOOKUP$fips, ]
melted <- melt(join(motor_nei, FIP_LOOKUP)[, c('Emissions', 'city', 'year')], id=c('year', 'city'))
data <- dcast(melted, year + city ~ variable, sum)

g <- qplot(year, Emissions, data=data, color=city, geom='line')
g + labs(title = 'Motor Vehicle Emissions Baltimore City VS Los Angeles County',
         y = 'Emissions in Tons (PM 2.5)')
ggsave(file="plot6.png", dpi=72)