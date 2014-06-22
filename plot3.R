library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
baltimore_pm25 <- NEI[NEI$fips==24510,]

selected_columns <- melt(baltimore_pm25[, c('Emissions', 'type', 'year')], id=c('year', 'type'))
clean_data <- dcast(h, year + type ~ variable, sum)

qplot(year, Emissions, data = clean_data, facets = . ~ type,
      geom=c('point', 'smooth'), method='lm')
ggsave(file="plot3.png", dpi=72)