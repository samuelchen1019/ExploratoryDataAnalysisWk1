##Libraries loading
library(tidyverse)
library(data.table)
library(lubridate)

##Data set downloading and unzipping
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName<-"projdata.zip"
if(!file.exists(fileName)){
  download.file(fileURL,fileName,method="curl")
}
unzip(fileName)
dt<-fread(file="household_power_consumption.txt")

##subsetting the data
dt<-subset(dt,dt$Date=="1/2/2007"|dt$Date=="2/2/2007")

##plotting 1
png("plot1.png", width=480, height=480)
hist(as.numeric(dt$Global_active_power),xlab = "Global Active Power(kilowatts)",col="red",main="Global Active Power",xlim=c(0,6))
dev.off()

##plotting 2
png("plot2.png", width=480, height=480)
dt<-mutate(dt,datetime=paste(Date,Time))
dt$datetime<-as.POSIXct(dt$datetime)
plot(dt$datetime,as.numeric(dt$Global_active_power),type="l",xlab="",ylab="Global Active Power (kilowatts)",main="Global Active Power Vs Time") 
dev.off()

##plotting 3
png("plot3.png", width=480, height=480)
plot(dt$datetime,as.numeric(dt$Sub_metering_1),type = "n",xlab="",ylab="Energy sub metering")
with(dt,lines(datetime,as.numeric(Sub_metering_1)))
with(dt,lines(datetime,as.numeric(Sub_metering_2),col="red"))
with(dt,lines(datetime,as.numeric(Sub_metering_3),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

##plotting 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(dt$datetime,as.numeric(dt$Global_active_power),type="l",xlab="",ylab="Global Active Power")
plot(dt$datetime,as.numeric(dt$Voltage),type="l",xlab="datetime",ylab="Voltage")
plot(dt$datetime,as.numeric(dt$Sub_metering_1),type = "n",xlab="",ylab="Energy sub metering")
with(dt,lines(datetime,as.numeric(Sub_metering_1)))
with(dt,lines(datetime,as.numeric(Sub_metering_2),col="red"))
with(dt,lines(datetime,as.numeric(Sub_metering_3),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(dt$datetime,as.numeric(dt$Global_reactive_power),type="l",xlab="datetime",ylab="Global Reactive Power")
dev.off()