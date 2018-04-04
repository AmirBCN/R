#rm(list = ls())
library(dplyr)
library(ggplot2)
#NEI <- readRDS("/Users/AmirSona/Desktop/R/Assignment4/Data/summarySCC_PM25.rds")
#SCC <- readRDS("/Users/AmirSona/Desktop/R/Assignment4/Data/Source_Classification_Code.rds")
# Question 1

#  TotalPM25 <-  with(NEI, tapply(Emissions, year, sum))
#  year <- as.numeric(names(TotalPM25))
#  plot(year, TotalPM25, xlab = "Year", ylab = "Total Pm2.5 Emission")
#  lines(year, TotalPM25)
# 
# # Question 2
# 
# DataBaltimore <- subset(NEI, fips == "24510")
# TotalPM25Baltimore <-  with(DataBaltimore, tapply(Emissions, year, sum))
# year <- as.numeric(names(TotalPM25))
# plot(year, TotalPM25Baltimore, xlab = "Year", ylab = "Total Pm2.5 Emission in Baltimore", xlim = c(1998,2008))
# lines(year, TotalPM25Baltimore)

# using dplyr
# DataBaltimore <- subset(NEI, fips == "24510")
# DataBaltimoreYear <- group_by(DataBaltimore, year)
# PM25BaltimoreYear <- summarise(DataBaltimoreYear, Emissions =  sum(Emissions))
# plot(PM25BaltimoreYear$year, PM25BaltimoreYear$Emissions, xlab = "Year", ylab = "Total Pm2.5 Emission in Baltimore", xlim = c(1998,2008))
# lines(PM25BaltimoreYear$year, PM25BaltimoreYear$Emissions)

# Question 3, I use dplyr and ggplot2
# DataBaltimore <- subset(NEI, fips == "24510")
# DataBaltimoreYearType <- group_by(DataBaltimore, year, type)
# PM25BaltimoreYearType <- summarise(DataBaltimoreYearType, Emissions =  sum(Emissions))
# ggplot(PM25BaltimoreYearType , aes(x=year, y=Emissions, color=type)) + geom_point() + geom_line()

# Question 4
# CoalComb <- filter(SCC, grepl("Comb.*Coal|Coal.*Comb", Short.Name))
# Codes <- CoalComb$SCC
# DataCoalComb <- subset(NEI, SCC %in% Codes)
# DataCoalCombYear <- group_by(DataCoalComb, year)
# DataCoalCombYearSum <- summarise(DataCoalCombYear, Emissions =  sum(Emissions))
# ggplot(DataCoalCombYearSum , aes(x=year, y=Emissions)) + geom_point() + geom_line()

# Question 5 & 6
MotorVh <- subset(SCC, grepl("Moto.*Veh|Veh.*Moto", Short.Name))
Codes <- MotorVh$SCC
DataMotorVhBaltimoreLA <- subset(NEI, SCC %in% Codes & (fips == "24510" | fips == "06037"))
DataMotorVhBaltimoreLAYear <- group_by(DataMotorVhBaltimoreLA, year, fips)
DataMotorVhBaltimoreLAYearSum <- summarise(DataMotorVhBaltimoreLAYear, Emissions =  sum(Emissions))
ggplot(DataMotorVhBaltimoreLAYearSum , aes(x=year, y=Emissions, color = fips)) + geom_point() + geom_line()
ggsave("PM25.png")
