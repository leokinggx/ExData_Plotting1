library('data.table')


data_raw <- fread("household_power_consumption.txt",na.strings="?",
                  colClasses=c('string','string','numeric',
                               'numeric','numeric','numeric',
                               'numeric','numeric','numeric'))

png(filename = "plot1.png", width = 480, height = 480)
hist(data_int$Global_active_power,
     main='Global Active Power',xlab='Global Active Power (kilowwatts)')
dev.off()
