# Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Read input file if NEI data is not present in current environment.
# Notice input file should be in your working directory:
if(!exists("NEI")){
      NEI <- readRDS("./summarySCC_PM25.rds")
}

# Gets total emissions for that year
totalPM2.5 <- aggregate(NEI$Emissions, by = list(NEI$year), sum)
colnames(totalPM2.5)<- c("year","totalemissions")

# Save the plot in PNG file
png('plot1.png')
with(totalPM2.5,barplot(height=totalemissions,names.arg=year,xlab="Year",ylab=expression('Total PM'[2.5]*' emissions [Tons]')))
title("Total PM2.5 emissions per year in US [Unit: Tons]")
dev.off()