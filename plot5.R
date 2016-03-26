# Plot 5
# How have emissions from motor vehicle sources changed from 1999-2008
# in Baltimore City?

# Read input file if NEI/SCC data is not present in current environment.
# Notice input file should be in your working directory:
if(!exists("NEI")){
      NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
      SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset NEI for Baltimore City:
NEIBaltimore <- NEI[NEI$fips == "24510",]

# Join both dataframes by SCC:
dataBaltimore <- merge(NEIBaltimore,SCC,by="SCC",all.x=TRUE)

# Subset data obtaining only obtaining Motor vehicles -related emissions.
# In order to do that, "Mobile" and "Vehicles" must be find in "SCC$EI.Sector":
mvehicRelated  <- dataBaltimore[grepl("Mobile.*Vehicles", dataBaltimore$EI.Sector,ignore.case=TRUE),]

# Gets total emissions for that year
totalPM2.5mvehicRelated <- aggregate(mvehicRelated$Emissions, by = list(mvehicRelated$year), sum)
colnames(totalPM2.5mvehicRelated)<- c("year","totalemissions")

# Save the plot in PNG file
png("plot5.png")
with(totalPM2.5mvehicRelated,barplot(height=totalemissions,names.arg=year,xlab="Year",ylab=expression('Total PM'[2.5]*' emissions [Tons]')))
title("Total PM2.5 emissions in Baltimore due to Motor vehicles")
dev.off()