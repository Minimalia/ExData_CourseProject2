# Plot 3
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which 
# of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases 
# in emissions from 1999-2008? Use the ggplot2 plotting system 
# to make a plot answer this question.

# Read input file if NEI data is not present in current environment.
# Notice input file should be in your working directory:
if(!exists("NEI")){
      NEI <- readRDS("./summarySCC_PM25.rds")
}

# Loads ggplot2
library(ggplot2)

# Gets total emissions per year and city
totalPM2.5perCityType <- aggregate(NEI$Emissions, by = list(NEI$year,NEI$fips,NEI$type), sum)
colnames(totalPM2.5perCityType)<- c("year","fips","type","totalemissions")

# Save the plot in PNG file subsetting the data for Baltimore city
png("plot3.png", width=800, height=480)
g <- ggplot(totalPM2.5perCityType[totalPM2.5perCityType$fips == "24510",], 
            aes(year,totalemissions))
g <- g + geom_line() + geom_point() + xlab("Year") + ylab(expression('Total PM'[2.5]*' emissions [Tons]'))
g <- g + ggtitle("Total PM2.5 emissions per year in Baltimore City per Type [Unit: Tons]")
g <- g + facet_grid(.~ type)
print(g)
# with(totalPM2.5perCityType[totalPM2.5perCityType$fips == "24510",], 
#     qplot(year,totalemissions,facets=.~type,xlab="Year",ylab=expression('Total PM'[2.5]*' emissions [Tons]'),
#           main = "Total PM2.5 emissions per year in Baltimore City per Type [Unit: Tons]"))
dev.off()