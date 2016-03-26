# Plot 4
# Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999-2008?

# Read input file if NEI/SCC data is not present in current environment.
# Notice input file should be in your working directory:
if(!exists("NEI")){
      NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
      SCC <- readRDS("Source_Classification_Code.rds")
}

# Join both dataframes by SCC:
data <- merge(NEI,SCC,by="SCC",all.x=TRUE)

# Subset data obtaining only coal-related emissions:
coalRelated  <- data[grepl("coal", data$EI.Sector,ignore.case=TRUE),]

# Gets total emissions for that year
totalPM2.5coalRelated <- aggregate(coalRelated$Emissions, by = list(coalRelated$year), sum)
colnames(totalPM2.5coalRelated)<- c("year","totalemissions")

# Save the plot in PNG file
png("plot4.png")
with(totalPM2.5coalRelated,barplot(height=totalemissions,names.arg=year,xlab="Year",ylab=expression('Total PM'[2.5]*' emissions [Tons]')))
title("Total PM2.5 emissions per year coal related [Unit: Tons]")
dev.off()