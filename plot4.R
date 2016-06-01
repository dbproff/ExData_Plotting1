library(lubridate)
library(dplyr)
library(data.table)
rm(list = ls(all.names = TRUE))
wd <<- "c:/Users/user/Documents/R/4/week1/Assignment Course Project 1/"
gwd <- getwd()
if ( gwd != wd ) {setwd (wd)}

household_power_consumption <- read.table("~/R/4/week1/Assignment Course Project 1/household_power_consumption.txt", header=TRUE, sep=";",stringsAsFactors = FALSE, na.strings=c("?","", " "))
#dim(household_power_consumption)

# convert var 'Date' to date type
household_power_consumption$Date <- as.Date(household_power_consumption$Date,"%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
hpc <- subset(household_power_consumption,year(Date)==2007 & month(Date)==2 & day (Date) < 3)
rm(household_power_consumption)
dim(hpc)

hpc$timestamp  <- as.POSIXct(strptime(paste(hpc$Date, hpc$Time),"%Y-%m-%d %H:%M:%S"))

hpc <- hpc[,c(-1,-2)]

#  remove records with NA's

hpc <- hpc[complete.cases(hpc[,3:9]),]
dim(hpc)


## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(hpc, {
      # 1st plot
      plot(Global_active_power~timestamp, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      
      # 2nd plot
      plot(Voltage~timestamp, type="l", 
           ylab="Voltage (volt)", xlab="")
      # 3rd plot
      plot(Sub_metering_1~timestamp, type="l", 
           ylab="Energy Submetering", xlab="")
      lines(Sub_metering_2~timestamp,col='Red')
      lines(Sub_metering_3~timestamp,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
             ,  cex=0.5)
      # 4th plot
      plot(Global_reactive_power~timestamp, type="l", 
           ylab="Global_reactive_power",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()