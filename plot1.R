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
dim(hpc)

hpc$timestamp  <- as.POSIXct(strptime(paste(hpc$Date, hpc$Time),"%Y-%m-%d %H:%M:%S"))
hpc <- hpc[,c(-1,-2)]

#  remove records with NA's

hpc <- hpc[complete.cases(hpc[,3:9]),]
dim(hpc)
 
## draw Plot 1
hist(hpc$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency"
     , col="Red", main="Global Active Power")
## Save plot to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
