##set current termial Locale in case your default setting is not English, which will cause time scale looks different with sample file
Sys.setlocale("LC_TIME", "English")

##load required library
library(sqldf)
library(dplyr)
##read origianl data by specific condition
EPCdata <- read.csv.sql("household_power_consumption.txt", sep=";", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", colClasses = rep("character", 9))

##format data
EPCdata[,3:9] <- lapply(EPCdata[,3:9], as.numeric)
temp = mutate(EPCdata,Timestamp = paste(Date, Time, sep = ' '))
temp$Timestamp<-strptime(temp$Timestamp, "%d/%m/%Y %H:%M:%S")

##draw graph
plot(temp$Timestamp, temp$Global_active_power, type="n", main="", ylab="Gloabl Active Power(kilowatts)", xlab="") 
lines(temp$Timestamp, temp$Global_active_power, type='l') 

##copy graph to png and close it
dev.copy(png, file = "plot2.png")
dev.off()