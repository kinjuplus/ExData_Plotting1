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
plot(temp$Timestamp, temp$Sub_metering_1, type="n", main="", ylab="Energy sub metering", xlab="") 
lines(temp$Timestamp, temp$Sub_metering_1, type="l") 
lines(temp$Timestamp, temp$Sub_metering_2, type="l",col="red")
lines(temp$Timestamp, temp$Sub_metering_3, type="l",col="blue")
legend("topright", lty=c(1,1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))  

##copy graph to png and close it
dev.copy(png, file = "plot3.png")
dev.off()