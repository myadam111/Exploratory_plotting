
#loading NEI and SCC data frames from the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#sub-setting only Baltimore city
req_df <- subset(NEI, fips == "24510")

# applying sum function on emissions by aggregating by year
PM25sum_byYear <- aggregate(Emissions ~ year, req_df, sum)

#plotting the bar graph of year vs emissions
with(PM25sum_byYear, barplot(height = Emissions, names.arg =year, xlab = "Year", ylab = "Pm2.5 emissions in tons", main = " Total emissions by all Sources in Baltimore City", ylim = c(0,4000),col = "red"))
#copying the graph as png file
dev.copy(png, file = "./plot2.png",width=480,height=480)
dev.off()
