############
############
############
set.seed(1234567890)
library(geosphere)

stations = read.csv("stations.csv")
temps = read.csv("temps50k.csv")
ind = sample(1:50000, 5000)
st = merge(stations,temps,by="station_number")
st = st[ind,]

######## h values used to smooth the graph ########
h_distance = 50000 #50000
h_date = 30        #30
h_time = 3         #3

######## The point to predict ########
a = 58.4274 #Latitude
b = 14.826  #Longitude

######## The date to predict ########
date = "2013-11-04"

times = c("04:00:00", "06:00:00", "08:00:00","10:00:00","12:00:00","14:00:00"
          ,"16:00:00","18:00:00","20:00:00", "22:00:00","24:00:00")

dates = c("2013-01-04","2013-02-04","2013-03-04","2013-04-04","2013-05-04","2013-06-04","2013-07-04",
          "2013-08-04","2013-09-04","2013-10-04","2013-11-04","2013-12-04")

temp = vector(length=length(times))

######## Converts time to hours ########
time_to_hour = function  (string)
{
  hhmmss = strsplit (string, ":", T)
  hh = as.numeric (hhmmss[[1]][1])
  mm = as.numeric (hhmmss[[1]][2])
  ss = as.numeric (hhmmss[[1]][3])
  return (hh + mm/60 + ss/(60*60))
}

######## Take out everything prior to the day of interest ########
reorderedData = st[order(st$date,decreasing = FALSE),]
tempDate = as.Date(as.character(reorderedData$date), format="%Y-%m-%d") < as.Date(date, format="%Y-%m-%d")
tempDate2 = tempDate[tempDate != FALSE]
newTemp = reorderedData[1:length(tempDate2),] #Everything prior to the day of interest

######## Loop through all different times ########
for(i in 1:length(times)){

  ######## Take of everything prior to the hour of interest ########
  reorderedData2 = newTemp[order(newTemp$time,decreasing = FALSE),]
  tempTime = as.difftime(as.character(reorderedData2$time)) < as.difftime(times[i])
  tempTime2 = tempTime[tempTime != FALSE]
  newTemp2 = reorderedData2[1:length(tempTime2),] #Everything prior to the hour of interest
  
  #################### Testing Kernel 2 #################
  #reorderedData = st[order(st$date,decreasing = FALSE),]
  #tempDate = as.Date(as.character(reorderedData$date), format="%Y-%m-%d") < as.Date(dates[i], format="%Y-%m-%d")
  #tempDate2 = tempDate[tempDate != FALSE]
  #newTemp2 = reorderedData[1:length(tempDate2),] #Everything prior to the day of interest
  
  #######################################################
  
  ktot = 0
  tempTot = 0
  
  ######## Loop through all values that are prior to the given date and time ########
  for(j in 1:dim(newTemp2)[1]){
    u1 = distHaversine(c(newTemp2$latitude[j],newTemp2$longitude[j]),c(a,b))
    u1 = u1/h_distance
    k1 = exp(-u1^2) 
    
    u2 = as.Date(date, format="%Y-%m-%d")-as.Date(as.character(newTemp2$date[j]), format="%Y-%m-%d")
    u2 = u2/h_date
    k2 = exp(-as.numeric(u2)^2) 
 
    u3 = time_to_hour(times[i])-time_to_hour(as.character(newTemp2$time[j]))
    u3 = u3/h_time
    k3 = exp(-u3^2) 
  
    ######## Sum of Gaussian K¤ernels ########
    k = k1+k2+k3
    
    tempTot = tempTot + k*newTemp2$air_temperature[j]
    ktot = ktot + k;
  }
  
  ######## Total temperature (temperature*weight) divided by total weight ########
  temp[i] = tempTot/ktot
}


plot(temp, type="o",col="blue")




