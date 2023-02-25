#loading NEI and SCC data frames from the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# getting logical vector containing coal and extracting ssc
coal_comb <- SCC[grepl("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]

#extracting required scc columns from the main database
coal_comb_NEI <- NEI[(NEI$SCC %in% coal_comb),]

# applying sum function on emissions by aggregating by year
PM25sum_byYear <- aggregate(Emissions ~ year, coal_comb_NEI, sum)


#loading ggplot2 library
library(ggplot2)

#plotting the bar graph between year and total emissions
ggplot(PM25sum_byYear, aes(factor(year),Emissions/1000, fill = year))+geom_bar(stat = "identity")+labs(title = "Total emissions by  coal combustion-related sources by year",x="Year",y = "Emissions in Ktons")

#copying the graph as png file
dev.copy(png, file = "./plot4.png",width=480,height=480)
dev.off()
