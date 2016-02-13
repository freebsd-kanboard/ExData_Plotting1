rm(list=ls())
p.url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
p.row.from = 66637
p.row.to = 69517
p.data.in = 'household_power_consumption.txt'
p.wanted.working.directory = "ExData_Plotting1"

p.saved.working.directory = getwd()
setwd(p.wanted.working.directory)

tfile = tempfile()
tdir = tempdir()
download.file(p.url, tfile)

unzip(tfile, exdir = tdir)

dt = read.delim(file.path(tdir, p.data.in),
                header = FALSE,
                skip = p.row.from,
                nrows = p.row.to - p.row.from,
                na.strings = '?',
                sep = ';',
                col.names = c('Date', 'Time', 'Global_active_power',
                              'Global_reactive_power', 'Voltage',
                              'Global_intensity', 'Sub_metering_1',
                              'Sub_metering_2', 'Sub_metering_3'),
                dec = '.'
                )

DateTime = strptime(paste(dt$Date, dt$Time), format = "%e/%m/%Y %T", tz = "UTC")
dt = cbind(dt, DateTime)

png(filename="plot3.png", width = 480, height = 480)
plot(dt$DateTime, dt$Sub_metering_1, type = "n", xlab = "", ylab = "")
points(dt$DateTime, dt$Sub_metering_1, type = "l")
points(dt$DateTime, dt$Sub_metering_2, type = "l", col = "red")
points(dt$DateTime, dt$Sub_metering_3, type = "l", col = "blue")
title(ylab = "Energy sub metering")
legend("topright"
       , lty = c(1, 1, 1)
       , col=c("black", "red","blue")
       , legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))


dev.off()
setwd(p.saved.working.directory)

#unlink(tdir, recursive = TRUE, force = TRUE)
unlink(tfile, recursive = TRUE, force = TRUE)

