# Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Read input file if NEI data is not present in current environment.
# Notice input file should be in your working directory:
if(!exists("NEI")){
      NEI <- readRDS("./summarySCC_PM25.rds")
}

# Gets total emissions per year and city
totalPM2.5perCity <- aggregate(NEI$Emissions, by = list(NEI$year,NEI$fips), sum)
colnames(totalPM2.5perCity)<- c("year","fips","totalemissions")

# Save the plot in PNG file subsetting the data for Baltimore city
png('plot2.png')
with(totalPM2.5perCity[totalPM2.5perCity$fips == "24510",], 
     barplot(height=totalemissions,names.arg=year,xlab="Year",ylab=expression('Total PM'[2.5]*' emissions [Tons]')))
title("Total PM2.5 emissions per year in Baltimore [Unit: Tons]")
dev.off()