source("get_dataset.R")

make_plot3 <- function() {
    # read dataset, prefiltering so only early february dates are imported
    # get_dataset downloads and unpacks, then returns name of the raw data file
    data <- read.csv(pipe(paste('grep -E \"Date|^[12]/2/2007\"', get_dataset())),
                     sep = ";", na.strings = "?")
    data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
    data$Date <- as.Date(data$Time)
    
    png("plot3.png")
    with(data, {
        plot(Time, Sub_metering_1, type = "l",
             xlab = "", ylab = "Energy sub metering" )
        points(Time, Sub_metering_2, type = "l", col = "red")
        points(Time, Sub_metering_3, type = "l", col = "blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, col = c("black", "red", "blue"))
        })
    dev.off()
}
