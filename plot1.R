source("get_dataset.R")

make_plot1 <- function() {
    # read dataset, prefiltering so only early february dates are imported
    # get_dataset downloads and unpacks, then returns name of the raw data file
    data <- read.csv(pipe(paste('grep -E \"Date|^[12]/2/2007\"', get_dataset())),
                     sep = ";", na.strings = "?")
    data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
    data$Date <- as.Date(data$Time)

    png("plot1.png")
    hist(data$Global_active_power,
            xlab = "Global Active Power (kilowatts)",
            main = "Global Active Power", col="red")
    dev.off()
}
