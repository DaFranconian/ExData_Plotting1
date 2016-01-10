## Code to read subset of given data and create plot2

## Read File (should be contained in a separate "data" folder)
data <- "./data/houspowcons.txt" ## rename file name if necessary

## Define custom date format for import
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
consumption <- read.table(data, sep=";", header=TRUE, na.strings="?", colClasses=c('Date'='myDate'))

## modify time frame if necessary
startDate <- as.Date("2007-02-01") 
endDate <- as.Date("2007-02-02")

## subsetting data for later use
con_subset <- consumption[as.Date(consumption$Date,"%d/%m/%Y") >= startDate & 
                                  as.Date(consumption$Date,"%d/%m/%Y") <= endDate,]

## create plot 1 and save it as PNG
attach(con_subset)
hist(as.numeric(Global_active_power), col="red",xlab="Global Active Power (kilowatts)",
              main="Global Active Power")
dev.copy(png, file="plot1.png")
dev.off() ## Close PNG device