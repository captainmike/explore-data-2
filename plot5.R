NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BALTIMORE_FIPS <- 24510
motor_scc <- SCC[grepl('motor', SCC[['Short.Name']], ignore.case = TRUE, perl = TRUE), ]
motor_nei <- NEI[NEI$SCC %in% motor_scc$SCC & NEI$fips==BALTIMORE_FIPS, ]

year_sums <- tapply(motor_nei$Emissions, motor_nei$year, sum)
data <- ldply(year_sums)
names(data) <- c('Year', 'Emissions')

png(filename='plot5.png')
barplot(data$Emissions, names.arg = data$Year,
        ylab='Emissions in Tons (PM 2.5)', xlab='Year', col='blue')
title(main = "Emissions from Motor Vehicle Sources in Baltimore, Maryland", font.main = 1)
dev.off()