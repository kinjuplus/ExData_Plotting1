##load required library
library(sqldf)
##read origianl data by specific condition
EPCdata <- read.csv.sql("household_power_consumption.txt", sep=";", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", colClasses = rep("character", 9))

##format data
EPCdata[,3:9] <- lapply(EPCdata[,3:9], as.numeric)

##draw graph
with(EPCdata, hist(Global_active_power,col="red",main = "Global Active Power",xlab="Global Active Power(kilowatts)"))

##copy graph to png and close it
dev.copy(png, file = "plot1.png")
dev.off()