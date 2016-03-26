# Plot 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# Loads ggplot2
library(ggplot2)

# Read input file if NEI/SCC data is not present in current environment.
# Notice input file should be in your working directory:
if(!exists("NEI")){
      NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
      SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset NEI for Baltimore and California:
NEIBaltimore <- NEI[NEI$fips == "24510",]
NEICalifornia <- NEI[NEI$fips == "06037",]

# Join both dataframes by SCC for each city:
dataBaltimore <- merge(NEIBaltimore,SCC,by="SCC",all.x=TRUE)
dataCalifornia <- merge(NEICalifornia,SCC,by="SCC",all.x=TRUE)

# Subset data obtaining only obtaining Motor vehicles -related emissions.
# In order to do that, "Mobile" and "Vehicles" must be find in "SCC$EI.Sector":
mvehicBaltimore  <- dataBaltimore[grepl("Mobile.*Vehicles", dataBaltimore$EI.Sector,ignore.case=TRUE),]
mvehicCalifornia  <- dataCalifornia[grepl("Mobile.*Vehicles", dataCalifornia$EI.Sector,ignore.case=TRUE),]

# Gets total emissions for every year in each city
tmp1 <- aggregate(mvehicBaltimore$Emissions, by = list(mvehicBaltimore$year), sum)
colnames(tmp1)<- c("year","totalemissions")
tmp1$City <- "Baltimore"
tmp2 <- aggregate(mvehicCalifornia$Emissions, by = list(mvehicCalifornia$year), sum)
colnames(tmp2)<- c("year","totalemissions")
tmp2$City <- "Los Angeles"

# Merge both in same data frame:
dataCityComparison <- rbind(tmp1,tmp2)

# Save the plot in PNG file
png("plot6.png")
#First option: both in same plot
#g <- ggplot(dataCityComparison, 
#            aes(year,totalemissions, color= City))
#g <- g + geom_line() + xlab("Year") + ylab(expression('Total PM'[2.5]*' emissions [Tons]'))
#g <- g + ggtitle("Total PM2.5 emissions due to Motor vehicles")
#print(g)

#Second option: different facets
g <- ggplot(dataCityComparison, 
            aes(year,totalemissions))
g <- g + geom_line() + geom_point() + xlab("Year") + ylab(expression('Total PM'[2.5]*' emissions [Tons]'))
g <- g + ggtitle("Total PM2.5 emissions due to Motor vehicles")
g <- g + facet_grid(.~City) + geom_smooth(method = "lm")
print(g)

dev.off()