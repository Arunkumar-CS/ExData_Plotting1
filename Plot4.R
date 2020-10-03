household_power_consumption <-
  read.csv("household_power_consumption.txt",
           sep = ";")

household_power_consumption$TimeStamp <-
  strptime(
    paste(
      household_power_consumption$Date,
      " ",
      household_power_consumption$Time
    ),
    "%d/%m/%Y %H:%M:%OS"
  )


#View(household_power_consumption)

temp_data <-
  subset(
    household_power_consumption,
    TimeStamp >= "2007-02-01 00:00:00" &
      TimeStamp < "2007-02-02 24:00:00"
  )

#View(temp_data)

generatePlotAndSaveAsPNG <- function(temp_data, png) {
  op <- par('col', 'col.axis', 'mar')
  on.exit(par(op))
  
  par(mfrow = c(2, 2))
  par(mar = c(5, 4, 2, 2))
  
  #Plot 1
  global_active_power <- as.numeric(temp_data$Global_active_power)
  plot(
    temp_data$TimeStamp,
    global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power"
  )
  
  #Plot 2
  voltage <- as.numeric(temp_data$Voltage)
  plot(
    temp_data$TimeStamp,
    voltage,
    type = "l",
    xlab = "datetime",
    ylab = "Voltage"
  )
  
  #Plot 3
  sub_metering_1 <- as.numeric(temp_data$Sub_metering_1)
  sub_metering_2 <- as.numeric(temp_data$Sub_metering_2)
  sub_metering_3 <- as.numeric(temp_data$Sub_metering_3)
  
  plot(
    temp_data$TimeStamp,
    sub_metering_1,
    type = "l",
    xlab = "",
    ylab = "Energy Sub Metering"
  )
  
  lines(
    temp_data$TimeStamp,
    sub_metering_2,
    type = "l",
    xlab = "",
    ylab = "",
    col = "red"
  )
  
  lines(
    temp_data$TimeStamp,
    sub_metering_3,
    type = "l",
    xlab = "",
    ylab = "",
    col = "blue"
  )
  
  text =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  legend(
    "topright",
    lty = 1,
    legend = text,
    col = c("black", "red", "blue"),
    text.width = strwidth(text) * 2,
    bty = "n"
  )
  
  #Plot 4
  Global_reactive_power <-
    as.numeric(temp_data$Global_reactive_power)
  plot(temp_data$TimeStamp,
       Global_reactive_power,
       type = "l",
       xlab = "datetime")
  
  
  dev.copy(png, "Plot4.png", width = 480, height = 480)
  dev.off()
}

generatePlotAndSaveAsPNG(temp_data, png)
