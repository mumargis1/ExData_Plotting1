power_consumption_data <- read.table("E:/Courses/course_work/coursera/R_spetilization (john hopkin)/Explanatory_data_analysis/exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";")

#combining the date and time and merging to the main data in separate column

full_data_time <- strptime(paste(power_consumption_data$Date, power_consumption_data$Time, sep= " "), "%d/%m/%Y %H:%M:%S")
power_consumption_data <- cbind(power_consumption_data, full_data_time)

power_consumption_data$Date <- as.Date(power_consumption_data$Date, format = "%d/%m/%Y")
power_consumption_data$Time <- format(power_consumption_data$Time, format = "%H:%M:%S")
power_consumption_data$Global_active_power <- as.numeric(power_consumption_data$Global_active_power) 
power_consumption_data$Global_reactive_power <- as.numeric(power_consumption_data$Global_reactive_power)
power_consumption_data$Voltage <- as.numeric(power_consumption_data$Voltage)
power_consumption_data$Global_intensity <- as.numeric(power_consumption_data$Global_intensity)
power_consumption_data$Sub_metering_1 <- as.numeric(power_consumption_data$Sub_metering_1)
power_consumption_data$Sub_metering_2 <- as.numeric(power_consumption_data$Sub_metering_2)
power_consumption_data$Sub_metering_3 <- as.numeric(power_consumption_data$Sub_metering_3)


subset_data <- subset(power_consumption_data, Date=="2007-02-01" | Date =="2007-02-02")



## plot the 4 graphs

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

with(subset_data, plot(full_data_time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subset_data, plot(full_data_time, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subset_data, plot(full_data_time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subset_data$full_data_time, subset_data$Sub_metering_2,type="l", col= "red")
lines(subset_data$full_data_time, subset_data$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subset_data, plot(full_data_time, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()
