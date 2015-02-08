# retrieve dataset from web and unpack as needed & return name of data file.
# assumes windows using download.file with wb mode
get_dataset <- function() {
    if (!file.exists("data")) 
        dir.create("data")
    setwd("data")
    if (!file.exists("household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "household_power_consumption.zip", mode = "wb")
        cat(date(), file="household_power_consumption.download.time.txt")
    }
    if (!file.exists("household_power_consumption.txt"))
        unzip("household_power_consumption.zip")
    setwd("..")
    "data/household_power_consumption.txt"
}


# read data and subset for first two days in february 2007 - inefficient & slow
#read_dataset_slow <- function() {
#    data_full <- read.csv(get_dataset(), sep=";", na.strings="?")
#    data <- subset(data_full, Date == "1/2/2007" | Date == "2/2/2007")
#}


# read data through a pipe to filter the source data before import
# assumes mac, linux, or windows system configured with posix commands
read_dataset <- function() {
    data <- read.csv(pipe(paste('grep -E \"Date|^[12]/2/2007\"', get_dataset())),
                     sep = ";", na.strings = "?")
    data$Time <- strptime(paste(d$Date, d$Time), "%d/%m/%Y %H:%M:%S")
    data$Date <- as.Date(data$Time)
    data
}
