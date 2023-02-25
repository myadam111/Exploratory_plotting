#loading NEI and SCC data frames from the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#sub-setting only Baltimore city
req_df <- subset(NEI, fips == "24510")

#loading ggplot2 library
library(ggplot2)

#plotting the bar graph between year and total emissions by type os source
ggplot(req_df, aes(factor(year),Emissions, fill = type))+geom_bar(stat = "identity")+facet_wrap(.~type, nrow = 1, ncol=4)+labs(title = " Total emissions by four types of sources in Baltimore city" , x="Year")

#copying the graph as png file
dev.copy(png, file = "./plot3.png",width=480,height=480)
dev.off()
