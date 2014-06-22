NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

comb_coal_scc <- SCC[grepl('(?=.*comb)(?=.*coal)', SCC[['EI.Sector']], ignore.case = TRUE, perl = TRUE), ]
comb_coal_nei <- NEI[NEI$SCC %in% comb_coal_scc$SCC, ]

year_sums <- tapply(comb_coal_nei$Emissions, comb_coal_nei$year, sum)
data <- ldply(year_sums)
names(data) <- c('Year', 'Emissions')

png(filename='plot4.png')
barplot(data$Emissions, names.arg = data$Year,
        ylab='Coal Combustion-related Emissions in Tons (PM 2.5) across United States', xlab='Year', col='blue')
dev.off()