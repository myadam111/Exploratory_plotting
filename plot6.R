#loading NEI and SCC data frames from the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#getting logical vector containing motor vehicle sources and extracting ssc
motor_veh_scc <- SCC[grepl("Vehicle", SCC$SCC.Level.Two), "SCC"]

#extracting required scc columns from the main database
motor_veh_NEI <- NEI[(NEI$SCC %in% motor_veh_scc),]

#sub-setting only Baltimore city
req_bal_df <- subset(motor_veh_NEI, fips == "24510")
req_bal_df$city <- "Baltimore city"

#sub-setting only Los Angeles city
req_la_df <- subset(motor_veh_NEI, fips == "06037")
req_la_df$city <- "Los Angeles city "

#combining two data frames
req_bol_la_df <- rbind(req_bal_df,req_la_df)


#loading ggplot2 library
library(ggplot2)

#plotting the bar graph between year and total emissions
ggplot(req_bol_la_df, aes(factor(year),Emissions, fill = city))+geom_bar(stat = "identity")+labs(title = "Emissions by motor vehicles in Baltimore City and Los Angeles city",x="Year",y = "Emissions in tons")+facet_wrap(.~city, nrow = 1, ncol=2)

#copying the graph as png file
dev.copy(png, file = "./plot6.png",width=480,height=480)
dev.off()
