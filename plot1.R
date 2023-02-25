
#loading NEI and SCC data frames from the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# applying sum function on emissions by aggregating by year
PM25sum_byYear <- aggregate(Emissions ~ year, NEI, sum)

#plotting the bar graph of year vs emissions
with(PM25sum_byYear, barplot(height = Emissions/1000, names.arg =year, xlab = "Year", ylab = "the Total PM2.5(Ktons) emission from all sources ", main = " Total emissions by Year", ylim = c(0,8000),col = "blue"))

#copying the graph as png file
dev.copy(png, file = "./plot1.png",width=480,height=480)
dev.off()
