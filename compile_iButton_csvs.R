 rm(list = ls())
#all ibutton csv files have to be in the working directory
setwd("C:/Users/dmerges/Dropbox/02_PhD/ibuttons/2016/ibuttonr/")

## Importing multiple .csv files into R
temp = list.files(pattern="*.csv")
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv), envir = .GlobalEnv)
#plot and check visually
plot(D1950_B1_SF$TempC) #fehlt ->kaputt gewesen
plot(S1850_B3_SF$TempC) #fehlt ->kaputt gewesen
#rest looks fine 

rm(list = ls())

## extract mean, max, min and standard deviation
#snow cover -> in days: 1 day of snow cover = 6x <=0.5°C
files <- list.files(pattern = ".csv") ## creates a vector with all file names in your folder
T_mean <- rep(0,length(files))
T_max <- rep(0,length(files))
T_min<- rep(0,length(files))
T_sd<- rep(0,length(files))
snow_cover<- rep(0,length(files))
growing_days <- rep(0,length(files))
for(i in 1:length(files)){
   data <- read.csv(files[i],header=T)
   T_mean[i] <- mean(data$TempC)
   T_max[i] <- max(data$TempC)
   T_min[i] <- min(data$TempC)
   T_sd[i] <- sd(data$TempC)
   snow_cover[i] <- sum(data$TempC<=0.5)/6
   growing_days[i] <- sum(data$TempC>=5)/6
      }
 result <- cbind(files,T_mean,T_max,T_min,T_sd,snow_cover,growing_days)
 #remove expermimental ID
 result = gsub("_SF.csv", "", result)
 result = as.data.frame(result)
row.names(result) = result[,1]
result = result[,2:7]
 write.csv(result,file = "Temp_data_soil_fungi_15_16.csv")


 
 