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

sub_metering_1 <- as.numeric(temp_data$Sub_metering_1)
sub_metering_2 <- as.numeric(temp_data$Sub_metering_2)
sub_metering_3 <- as.numeric(temp_data$Sub_metering_3)

par(mfrow = c(1,1))
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
  text.width = strwidth(text) * 1.5
)


dev.copy(png, "Plot3.png", width = 480, height = 480)

dev.off()
