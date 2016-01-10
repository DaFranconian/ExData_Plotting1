## Code to read subset of given data and create plot2

## Read File (should be contained in a separate "data" folder)
data <- "./data/houspowcons.txt" ## rename file name if necessary

## Define custom date format for import
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))

consumption <- read.table(data, sep=";", header=TRUE, na.strings="?", colClasses=c("Date"="myDate"))

## modify time frame if necessary
startDate <- as.Date("2007-02-01") 
endDate <- as.Date("2007-02-02")

## subsetting data for later use
con_subset <- consumption[consumption$Date >= startDate & consumption$Date <= endDate,]

## joining data and time to create POSIXlt information
dateNew <- paste(con_subset$Date, con_subset$Time) ## character vector of date and time
dateNew <- strptime(dateNew,"%Y-%m-%d %H:%M:%S") ## conversion to date vector

con_subset2 <- data.frame(dateNew,con_subset[,-c(1,2)]) ## new subset containing new date

## create plot 2 and save it as PNG
plot(con_subset2$dateNew,con_subset2$Global_active_power,type="n",
     ylab="Global Active Power (kilowatts)", xlab="") ## create plot w/o values
lines(con_subset2$dateNew,con_subset2$Global_active_power) ## add line of values
dev.copy(png, file="plot2.png")
dev.off() ## Close PNG device