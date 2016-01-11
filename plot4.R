library('data.table')
library('dplyr')


data_raw <- fread("household_power_consumption.txt",na.strings="?",
                  colClasses=c('string','string','numeric',
                               'numeric','numeric','numeric',
                               'numeric','numeric','numeric'))



data_int <- filter(data_raw, as.Date(Date,"%d/%m/%Y") %in% as.Date(c( "01/02/2007",'02/02/2007'),"%d/%m/%Y") )
data_int$DateTime <- data_int[,paste(Date,Time)]
data_int$DateTime <- as.POSIXct(strptime(data_int$DateTime,"%d/%m/%Y %H:%M:%S"))

data_int <- arrange(data_int,DateTime)

png(filename = "plot4.png", width = 480, height = 480)

par(mfcol=c(2,2))
par(mar=c(1,2,2,1))
par(oma=c(1,1,1,1))

plot(data_int$Global_active_powe~data_int$DateTime,type = 'l',
     ylab='Global Active Powe (kilowwatt)',xlab='DateTime')

plot(data_int$Sub_metering_1 ~data_int$DateTime,type = 'l',
     ylab='Energy Sub Metering',xlab='DateTime')
lines(data_int$Sub_metering_2 ~data_int$DateTime,type = 'l',col='red')
lines(data_int$Sub_metering_3 ~data_int$DateTime,type = 'l',col='blue')
legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lty=c(1,1,1))

with(data_int,plot(Voltage~DateTime,type ='l'))

with(data_int,plot(Global_reactive_power~DateTime,type ='l'))



dev.off()
