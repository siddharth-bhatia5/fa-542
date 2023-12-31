### Lecture 1 ###
library(quantmod)   # Load the package
getSymbols("AAPL")  # Download daily prices of Apple stock from Yahoo
dim(AAPL)  # (dimension): See the size of the downloaded data.
head(AAPL)  # See the first 6 rows of the data
tail(AAPL)   # See the last 6 rows of the data 
chartSeries(AAPL,theme="white")  # Plot the daily price and volume
chartSeries(AAPL)#Not shown giving the same plot with black background.
getSymbols("AAPL",from="2005-01-02", to="2010-12-31")
head(AAPL)
getSymbols("UNRATE",src="FRED")#Download unemployment rates from FRED.
head(UNRATE)
chartSeries(UNRATE,theme="white")  # Plot monthly unemployment rates
getSymbols("INTC",src="yahoo")  # Download data from Google.
head(INTC)
getSymbols("^TNX") # Download CBOE 10-year Treasures Notes
head(TNX)  
chartSeries(TNX,theme="white",TA=NULL) # Obtain plot without volume.
#
library(fBasics) # Load package

data_directory <- "C:/Users/sbhatia2/My Drive/University/Academics/Semester V/FA542 - Time Series with Application to Finance/FA542 - Lectures/FA542 - Lecture #2/Lecture_2_data/"

da=read.table(paste(data_directory, 'd-ibm-0110.txt', sep=""), header=T) # Load text data with names.

head(da) # See the first 6 rows
dim(da)  # Dimension of the data object "da".
da <- read.csv(paste(data_directory, "d-vix0411.txt", sep=""),header=T) # Load csv data with names.
#
library(quantmod)
getSymbols("AAPL",from="2007-01-03",to="2011-12-02") #Specify period
AAPL.rtn=diff(log(AAPL$AAPL.Adjusted)) # Compute log returns
chartSeries(AAPL.rtn,theme="white")
getSymbols("^TNX",from="2007-01-03",to="2011-12-02")
TNX.rtn=diff(TNX$TNX.Adjusted) # Compute changes
chartSeries(TNX.rtn,theme="white")
getSymbols("DEXUSEU",src="FRED") #Obtain exchange rates from FRED
head(DEXUSEU)
tail(DEXUSEU)
USEU.rtn=diff(log(DEXUSEU$DEXUSEU))
chartSeries(DEXUSEU,theme="white")
chartSeries(USEU.rtn,theme="white")
#
library(fBasics) # Load package
da=read.table(paste(data_directory, "d-mmm-0111.txt", sep=""),header=T) # Load data
# header=T means the first row of data file contains names.
# deafult is no names.
head(da) #Show the first 6 rows of data
mmm=da[,2]  # Obtain 3m simple returns
basicStats(mmm) #Compute summary statistics
mean(mmm)
var(mmm)
stdev(mmm) # standard deviation
t.test(mmm)  # Testing mean return = 0
s3=skewness(mmm)
T=length(mmm) # Sample size
t3=s3/sqrt(6/T) # Skewness test
pp=2*(1-pnorm(t3)) # Compute p-value
s4=kurtosis(mmm)
t4=s4/sqrt(24/T) # Kurtosis test
normalTest(mmm,method='jb') # JB-test
#
library(fBasics)
da=read.table(paste(data_directory, "d-mmm-0111.txt", sep=""),header=T) # Load data
mmm=da[,2] # Locate 3M simple returns
hist(mmm,nclass=30) # Histogram
d1=density(mmm)  # Obtain density estimate
range(mmm)  # Range of 3M returns
x=seq(-.1,.1,.001) # Create a sequence of x with increment 0.001.
y1=dnorm(x,mean(mmm),stdev(mmm))
plot(d1$x,d1$y,xlab='rtn',ylab='density',type='l')
lines(x,y1,lty=2)
library(quantmod)
getSymbols("AAPL",from="2011-01-03",to="2011-06-30")
X=AAPL[,1:4] # Locate open, high, low, and close prices
xx=cbind(as.numeric(X[,1]),as.numeric(X[,2]),as.numeric(X[,3]),as.numeric(X[,4]))
#source("ohlc.R") # Compile the R script
#ohlc(xx,xl="days",yl="price",title="Apple Stock")
#source("ma.R")  # Compile R script
getSymbols("AAPL",from="2010-01-02",to="2011-12-08")
x1=as.numeric(AAPL$AAPL.Close) # Locate close price
#ma(x1,21)
da=read.table(paste(data_directory, "m-ibmsp-2611.txt", sep=""),header=T)
head(da)
ibm=log(da$ibm+1) # Transform to log returns
sp=log(da$sp+1)
tdx=c(1:nrow(da))/12+1926 # Create time index
par(mfcol=c(2,1))
plot(tdx,ibm,xlab='year',ylab='lrtn',type='l')
title(main='(a) IBM returns')
plot(tdx,sp,xlab='year',ylab='lrtn',type='l') # X-axis first.
title(main='(b) SP index')
cor(ibm,sp)  # Obtain sample correlation
cor(sp5,ibm,method='spearman')
cor(sp5,ibm,method='kendall')
m1=lm(ibm~sp)  # Fit the Market Model (linear model)
summary(m1)
plot(sp,ibm,cex=0.8)  # Obtain scatter plot
abline(0.008,.807) # Add the linear regression line
#
da=read.table(paste(data_directory, "m-ibmsp-2611.txt", sep=""),header=T) #Load  data
dim(da)
ibm=log(da$ibm+1) # Compute log returns
sp=log(da$sp+1)
rt=cbind(ibm,sp) # Obtain bivariate returns
m1=apply(rt,2,mean) # Obtain sample means
v1=cov(rt) # Obtain sample covariance matrix
m1
v1
library(mnormt) # Load package
x=rmnorm(1029,mean=m1,varcov=v1) # Simulation
dim(x)
plot(x[,2],x[,1],xlab='sim-sp',ylab='sim-ibm',cex=0.8)

