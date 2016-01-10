## Code to read subset of given data and create plot3

## Read File (should be contained in a separate "data" folder)
data <- "./data/houspowcons.txt" ## rename file name if necessary

## Define custom date format for import
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
## Read data
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

## create plot 3 and save it as PNG
plot(con_subset2$dateNew,con_subset2$Sub_metering_1,type="n",ylab="Energy sub metering", 
              xlab="") ## create plot w/o values
## add lines of values
lines(con_subset2$dateNew,con_subset2$Sub_metering_1,col="black") 
lines(con_subset2$dateNew,con_subset2$Sub_metering_2,col="red")
lines(con_subset2$dateNew,con_subset2$Sub_metering_3,col="blue")
## add legend
legend("topright", col=c("black","red","blue"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## save as file
dev.copy(png, file="plot3.png")
dev.off() ## Close PNG device