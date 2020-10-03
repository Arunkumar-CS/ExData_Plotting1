household_power_consumption <-
  read.csv("household_power_consumption.txt", sep = ";")

#View(household_power_consumption)

household_power_consumption$Date <-
  as.Date(household_power_consumption$Date, "%d/%m/%Y")

temp_data <-
  subset(
    household_power_consumption,
    Date >= "2007-02-01" & Date <= "2007-02-02"
    )
  

#View(temp_data)

global_active_power <- as.numeric(temp_data$Global_active_power)

par(mfrow = c(1,1))

hist(
  global_active_power,
  col = "Red",
  xlab = "Global Active Power (kilowatts)",
  main = "Global Active Power"
)

dev.copy(png, "Plot1.png", width = 480, height = 480)

dev.off()
