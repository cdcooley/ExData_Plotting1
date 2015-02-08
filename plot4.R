source("get_dataset.R")

make_plot4 <- function() {
    # read dataset, prefiltering so only early february dates are imported
    # get_dataset downloads and unpacks, then returns name of the raw data file
    data <- read.csv(pipe(paste('grep -E \"Date|^[12]/2/2007\"', get_dataset())),
                     sep = ";", na.strings = "?")
    data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
    
    png("plot4.png")

    par(mfcol = c(2,2))
    
    with(data, plot(datetime, Global_active_power, type = "l",
                xlab = "", ylab = "Global Active Power"))

    with(data, {
        plot(datetime, Sub_metering_1, type = "l",
             xlab = "", ylab = "Energy sub metering" )
        points(datetime, Sub_metering_2, type = "l", col = "red")
        points(datetime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, col = c("black", "red", "blue"), bty = "n", cex = 0.9)
    })

    with(data, plot(datetime, Voltage, type = "l"))

    with(data, plot(datetime, Global_reactive_power, type = "l"))

    dev.off()
}
