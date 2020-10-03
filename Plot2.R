household_power_consumption <-
  read.csv("household_power_consumption.txt",
           sep = ";")

household_power_consumption$TimeStamp <-
  strptime(paste(household_power_consumption$Date, " ", household_power_consumption$Time), "%d/%m/%Y %H:%M:%OS")


#View(household_power_consumption)

temp_data <-
  subset(
    household_power_consumption,
    TimeStamp >= "2007-02-01 00:00:00" & TimeStamp < "2007-02-02 24:00:00"
  )


#View(temp_data)

global_active_power <- as.numeric(temp_data$Global_active_power)

par(mfrow = c(1,1))

plot(
  temp_data$TimeStamp, global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

dev.copy(png, "Plot2.png", width = 480, height = 480)

dev.off()