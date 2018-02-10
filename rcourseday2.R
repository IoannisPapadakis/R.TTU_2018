#' R course day 2/ Live coding
#' 10.Feb.2018
# Recap day 1
mydata <- 5
rm(mydata)
myvector <- c(3,5, 4.3, 6)
mean(gdp$date)
dataframe$newvariable <- NULL

?functionname

summary()
str()
head()
tail()

names(gdp)

#
piaac <- read.csv("http://www.ut.ee/~iseppo/piaacest.csv")

mean(piaac$earnhr, na.rm = T)
median(piaac$earnhr, na.rm = T)

piaac$logincome<- log(piaac$earnhr)

cor(piaac$pvnum1, piaac$pvlit1, use="complete.obs")


# Getting data in 
?read.csv
read.csv(na.strings = c(NA, "", " ", ".")
read.csv(strip.white = FALSE)
read.csv(fileEncoding = )

# 
# install.packages("eurostat")
library(eurostat)

eurostatgdp<- get_eurostat("tec00114")
View(head(eurostatgdp)) # this functions views the of eurostat
# for finance eg packages: "tidyquant" or "quandl"
# install.packages("wbstats")
library(wbstats)
#' this a commment
#' this is the second line of the comment

wbsearch("GDP per capita, PPP")
gdp.pc <- wb(indicator = "NY.GDP.PCAP.PP.KD", POSIXct = TRUE) 

# install.packages("devtools")
devtools::install_github("vincentarelbundock/WDI")
