#loading NEI and SCC data frames from the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#getting logical vector containing motor vehicle sources and extracting ssc
motor_veh_scc <- SCC[grepl("Vehicle", SCC$SCC.Level.Two), "SCC"]

#extracting required scc columns from the main database
motor_veh_NEI <- NEI[(NEI$SCC %in% motor_veh_scc),]

#sub-setting only Baltimore city
req_df <- subset(motor_veh_NEI, fips == "24510")

# applying sum function on emissions by aggregating by year
PM25sum_byYear <- aggregate(Emissions ~ year, req_df, sum)


#loading ggplot2 library
library(ggplot2)

#plotting the bar graph between year and total emissions
ggplot(PM25sum_byYear, aes(factor(year),Emissions))+geom_bar(stat = "identity", fill = "yellow")+labs(title = "Total emissions by motor vehicle sources in Baltimore City by year",x="Year",y = "Emissions in tons")+  geom_text(aes(label = round(Emissions)), vjust = -0.5)

#copying the graph as png file
dev.copy(png, file = "./plot5.png",width=480,height=480)
dev.off()
