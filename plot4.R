#Read raw data from txt and change time/date format
raw<-read.table("household_power_consumption.txt", sep=";",header = TRUE)
raw$Date<-as.Date(raw$Date,"%d/%m/%Y")
raw$Time<-paste(raw$Date,raw$Time)
raw$Time<-strptime(raw$Time, "%Y-%m-%d %H:%M:%S")

# Subset useful data
data<-subset(raw,raw$Date==as.Date("2007-02-01") | raw$Date==as.Date("2007-02-02"))

# Change character format to numeric
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

# Plotting the graph
png(file="/Users/Syahmi/Documents/R Class/ExData_Plotting1/plot4.png",
    width=480, height=480)
par(mfrow=c(2,2))

# Plot 1
with(data,plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))

# Plot 2
with(data,plot(Time, Voltage, type = "l", xlab="datetime", ylab="Voltage"))

# Plot 3 
with(data,plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering"))
with(data,lines(Time, Sub_metering_2, col="red"))
with(data,lines(Time, Sub_metering_3, col="blue"))
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# Plot 4
with(data,plot(Time, Global_reactive_power,type = "l", xlab="datetime"))

dev.off()