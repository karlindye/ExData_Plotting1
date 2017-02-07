## -------------------------------------------------------------- ##
## ------------ Exploratory Data Plotting Assignment 1 ---------- ##
## -------------------------------------------------------------- ##


# -- Stage 0 - Install and Load Libraries ----------------------- #
# --------------------------------------------------------------- #


list.of.packages <- c("dplyr")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

if(length(new.packages)) install.packages(new.packages)


library(dplyr)


# -- Stage 1 - Read Txt File to Date Frame ---------------------- #
# --------------------------------------------------------------- #

HPwrCnsmptn <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE, dec=".")


# -- Stage 2 - Replace ? with NA -------------------------------- #
# --------------------------------------------------------------- #

HPwrCnsmptn[HPwrCnsmptn == "?"] <- NA


# -- Stage 3 - Set Column Classes ------------------------------- #
# --------------------------------------------------------------- #

# -- 3.1 -- Numeric Columns

for (i in c(3:9)) {
        HPwrCnsmptn[,i] <- as.numeric(HPwrCnsmptn[,i])
}

# -- 3.2 -- Create Single Date/Time Column 

HPwrCnsmptn <- mutate(HPwrCnsmptn, DateTime = paste(Date, Time, sep = " "))

HPwrCnsmptn$DateTime <- strptime(HPwrCnsmptn$DateTime, "%d/%m/%Y %H:%M:%S")


# -- Stage 4 - Subset Data for Date Range ----------------------- #
# --------------------------------------------------------------- #

HPwrSubset <- subset(HPwrCnsmptn, Date == "1/2/2007" | Date == "2/2/2007")


# -- Stage 5 - Plot Graph --------------------------------------- #
# --------------------------------------------------------------- #

png(filename = "plot4.png", height = 480, width = 480)


# Set Parameters

par(mfrow = c(2,2), mar = c(4,5,2,2))


# Plot 1

with(HPwrSubset, plot(DateTime, Global_active_power, type = "l", ylab="Global Active Power", xlab = ""))


# plot 2

with(HPwrSubset, plot(DateTime, Voltage, type = "l", ylab="Voltage", xlab = "datetime"))


# Plot 3

with(HPwrSubset, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))

with(HPwrSubset, lines(DateTime, Sub_metering_2, type = "l", col = "red"))

with(HPwrSubset, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n", cex = 0.85, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Plot 4

with(HPwrSubset, plot(DateTime, Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab = "datetime"))


dev.off()

