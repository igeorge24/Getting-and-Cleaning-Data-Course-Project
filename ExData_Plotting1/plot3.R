# Getting and Cleaning Data Course Project 1
# Script to create plot 3
#
# 1) Unzip folder from course website and read in data
#    Note: folder should be in working directory   
#
unzip("exdata_data_household_power_consumption.zip")
colclass<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
colnames<-read.table("household_power_consumption.txt",sep=";",nrows=1,colClasses="character")
data2<-read.table("household_power_consumption.txt",sep=";",skip=66636,col.names=colnames,nrows=2880,na.strings="?",colClasses=colclass)
#
# 2) Combine date and time columns into new column and convert to POSIXlt format
#
data2$datetime<-paste(data2$Date,data2$Time)
data2$datetime2<-strptime(data2$datetime,format="%d/%m/%Y %H:%M:%S")
#
# 3) Create plot and print to png file named plot3.png
#
with(data2,plot(datetime2,Sub_metering_1,xlab="",ylab="Energy sub metering",type="n"))
lines(data2$datetime2,data2$Sub_metering_1,col="black")
lines(data2$datetime2,data2$Sub_metering_2,col="red")
lines(data2$datetime2,data2$Sub_metering_3,col="blue")
legend(x="topright",lty=c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
dev.copy(png,file="plot3.png")
dev.off()