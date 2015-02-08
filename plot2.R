source("get_dataset.R")

make_plot2 <- function() {
    # read dataset, prefiltering so only early february dates are imported
    # get_dataset downloads and unpacks, then returns name of the raw data file
    data <- read.csv(pipe(paste('grep -E \"Date|^[12]/2/2007\"', get_dataset())),
                     sep = ";", na.strings = "?")
    data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
    data$Date <- as.Date(data$Time)
    
    png("plot2.png")
    with(data, plot(Time, Global_active_power, type = "l",
         xlab = "", ylab = "Global Active Power (kilowatts)"))
    dev.off()
}
