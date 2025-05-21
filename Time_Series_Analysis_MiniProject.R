# Time Series - values measured at different points in time
## ---------------
#taking the open power systems data, which shows power consumption, wind, and solar in Germany

opsd <- read.csv("C:\\Users\\Jake16\\Documents\\R\\Time Series Analysis Project\\Open Power Systems Data.csv", row.names = "Date")
View(opsd) #i made the date index values

#project plan:
  #clean dataset
  #analysis - things like trends, patterns over time, etc.
  #visualizations

dim(opsd) #dimensions of data set
  #finds that there are 4383 rows, with 4 columns

str(opsd) #shows each column is numeric

row.names(opsd) #shows all indexes, or in this case, all dates used
opsd[c("1/8/2006","1/11/2006"),] #example of taking dates

summary (opsd) #quick summary

## -------------
opsd_norm <- read.csv("C:\\Users\\Jake16\\Documents\\R\\Time Series Analysis Project\\Open Power Systems Data.csv")
View(opsd_norm) #not having the date as the index. Good to have both copies

dates <- as.Date(opsd_norm$Date, format = "%m/%d/%Y")#changes the dates into usable dates in R
#the format is needed to show what the current structure is, so that R changes it correctly into its usable dates
head(dates) #verification that it is correct

#creating year/month/day columns
year <- as.numeric(format(dates,"%Y"))
head(year)#verify

month <- as.numeric(format(dates,"%m"))
head(month)#verify

day <- as.numeric(format(dates,"%d"))
head(day)#verify

opsd_clean <- cbind(opsd_norm,year,month,day) #adding these columns
View(opsd_clean)
##------------
#visualizations

#line plot - first idea
plot(opsd_clean$year, opsd_clean$Consumption, type="l", xlab = "year", ylab = "Consumption")
  #doesn't really give any valuable insights

plot(opsd_clean[,2], type = "l", xlab = "Year", ylab = "Consumption", xlim = c(2006,2018))
  #  next step, shows base throughout year to year average

csmp_plot <- plot(dates, opsd_clean[,2], xlab = "Year", ylab = "Consumption", xaxt = "n")
axis(1, at = as.Date(paste0(2006:2018, "-01-01")), labels = 2006:2018) #build my own labels
  #better, shows each data point and is clearer to see.

#we can make this into a function so that it can just call the other columns as well
opsd_plots <- function(y, ylab = "Consumption") {
  par(las = 2, cex.axis = 0.8)  # Style x-axis
  plot(dates, y,
       xlab = "Year", ylab = ylab,
       xaxt = "n", main = paste(ylab, "Over Time"))
  axis(1, at = as.Date(paste0(2006:2018, "-01-01")), labels = 2006:2018)
  grid()
}
par(mfrow = c(4, 1))  # 2 rows, 2 columns of plots
opsd_plots(opsd_clean[,2], ylab = "Consumption")
opsd_plots(opsd_clean[,3], ylab = "Wind")
opsd_plots(opsd_clean[,4], ylab = "Solar")
opsd_plots(opsd_clean[,5], ylab = "Wind & Solar")

par(mfrow = c(1,1)) #reset plot displays

#we can see some patterns from looking closely, like consumption higher in winter,
#lower in summer. This is even more obvious for solar and wind, which we can make
#assumptions about them later
##------------
  #these are seasonality trends. We can try to investigate these further

#plotting a single year

str(dates)
opsd_clean2 <- cbind (dates, opsd_clean) #make sure date format is correct
View(opsd_clean2)

#take year 2017
opsd_year2017 <- subset(opsd_clean2, subset = opsd_clean2$dates >= '2017-01-01' & 
                          opsd_clean2$dates <= '2017-12-31')
head(opsd_year2017)#confirm it worked

opsd_year_plots <- function(y, ylab = "Consumption") {
 plot(opsd_year2017[, 1], y, 
       xlab = "Date", ylab = ylab,
       xaxt = "n", main = paste(ylab, "in 2017"))
  months <- seq(from = as.Date("2017-01-01"), to = as.Date("2017-12-01"), by = "month")
  axis(1, at = months, labels = format(months, "%b"))  
  grid()
}

opsd_year_plots(opsd_year2017[,3], ylab = "Consumption")
  #can see how the summer, consumption decreases
opsd_year_plots(opsd_year2017[,4], ylab = "Wind")
  #less in summer, but not definitive
opsd_year_plots(opsd_year2017[,5], ylab = "Solar")
 #a lot more in summer, because sun is out more
opsd_year_plots(opsd_year2017[,6], ylab = "Wind & Solar")
  #doesn't really tell much


#zooming further... taking in only a month
opsd_jul2017 <- subset(opsd_year2017, subset = opsd_year2017$dates >= "2017-07-01" &
                       opsd_year2017$dates <= "2017-07-31")
opsd_month_plot <- function(y, ylab = "Consumption") {
  plot(opsd_jul2017[, 1], y, 
       type = "l",
       xlab = "Date", ylab = ylab,
       xaxt = "n", 
       main = paste(ylab, "in", format(opsd_jul2017[1, 1], "%B %Y")))
  
  ticks <- seq(from = min(opsd_jan2017[, 1]), to = max(opsd_jul2017[, 1]), by = "5 days")
  axis(1, at = ticks, labels = format(ticks, "%b %d"))
  
  grid()
}
opsd_month_plot(opsd_jul2017[,3], ylab = "Consumption")
#can conclude, consumption is highest on weekdays and lower on weekends. Each minimum is a weekend day


