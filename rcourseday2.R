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

# quick demo dataset
mydata <- data.frame(animal = c("elephant", "bear", "cat"), 
                     length = c(5,3,2), 
                     weight = c(10, 5, 1))
mydata

mydata$length[1]

mydata$weight[1] <- 12
mydata
mydata$length[c(2,3)]

mydata$length[-2]

mydata[1,2]
mydata[1,] # entire for row

mydata[, 3] # entire third column
mydata[c(2,3), ] # second and third row

mydata$animal[c(TRUE, FALSE, TRUE)]

# Conditional statements and logic in R

3>4

mydata$length > 2

mydata$animal[mydata$length > 2]
mydata[mydata$length > 2]

mydata$length[mydata$animal == "elephant"] <- 100


# Basic comparison 
x <- 3
z <- 4
x > 3
x >= 3
z < 4
z <= 4
x == z
x != z
is.na(x)
!is.na(x)

mydata$weight[1] <- NA
mydata
is.na(mydata$weight)
!is.na(mydata$weight)


x > 2 | z > 5
x > 2 & z > 5
mydata$length > 2 & mydata$length < 5


4 %in% c(2,3,4)
myanimals <- c("chicken", "duck", "bear")
"frog" %in% (myanimals)



# Filtering data
summary(piaac$edlevel3)
highschool <- subset(piaac, edlevel3 == "Medium")
summary(highschool$edlevel3)

highschool2 <- subset(piaac, 
                     edlevel3 == "Medium"& livingwithspouse == "Yes")
mean(highschool2$pvnum1, na.rm = TRUE)

sample3 <- subset(piaac, edlevel3 %in% c("High", "Medium"))
summary(sample3)
str(sample3)
edlevel <- c("High", "Medium")
sample4 <- subset(piaac, edlevel3 %in% edlevel)
str(sample4)

piaac<- subset(piaac, !is.na(edlevel3))
gdp <- read.csv("http://www.ut.ee/~iseppo/gdpestimate.csv")
gdp$difference <- gdp$firstEstimate - gdp$latestEstimate

yearsIwant <- c("2012", "2013", "2014")
sample5 <- subset(gdp, year %in% yearsIwant)
str(sample5)
summary(sample5$year)
mean(sample5$difference)

names(piaac)
sample6 <- subset(piaac,  
                  livingwithspouse == "Yes")
mean(subset(piaac, livingwithspouse == "Yes")$earnhr, na.rm=T)

mean(piaac$earnhr[piaac$livingwithspouse=="Yes"], na.rm=T)

str(sample6)
mean(sample6$earnhr, na.rm =  TRUE)

sample7 <- subset(piaac,  age > "34" & edlevel3 == "Medium")
str(sample7)
sample7$age
sample7$edlevel3

mean(sample7$earnhr, na.rm = TRUE)

# The tidyverse
## ggplot2

library(ggplot2)

gdp.pc
unique(gdp.pc$country)
gdp.pc.world <- subset(gdp.pc, country == "World")
gdp.pc.world

library(ggplot2)
ggplot(data = gdp.pc.world) +
  geom_point(aes(x = date_ct, y = value))


ggplot(data = gdp.pc.world) +
  geom_point(aes(x = date_ct, y = value)) +
  geom_line(aes(x=date_ct, y=value))

ggplot(data = gdp.pc.world, aes(x = date_ct, y = value)) +
  geom_point() +
  geom_line()



p.gdp <- ggplot(data = gdp.pc.world, 
                aes(x = date_ct, y = value)) +
  geom_point() +
  geom_line()
p.gdp


p.1 <- ggplot(data = gdp.pc.world, 
                aes(x = date_ct, y = value)) +
  geom_point() 

p.1 + geom_line()

ggsave(p.gdp, filename = "worldgdp.png", 
       height = 4, width = 4, scale = 2)

# Your turn
piaac <- read.csv("http://www.ut.ee/~iseppo/piaacest.csv")
piaac$logincome <- log(piaac$earnhr)
names(piaac)
ggplot(data = piaac, aes(x = pvnum1, y = logincome)) +
  geom_point(aes(color = gender,
                 shape = children), alpha = 0.5) +
  geom_smooth()

# remove observations where children is.na
piaac <- subset(piaac, !is.na(children))

?geom_smooth

ggplot(data = piaac, aes(x = pvnum1, y = logincome)) +
  geom_point() +
  geom_smooth(aes(color = gender))

# Your turn
gdp <- read.csv("http://www.ut.ee/~iseppo/gdpestimate.csv")
str(gdp)
gdp$date <- as.Date(gdp$date)

ggplot(data = gdp, aes(x = date, y = latestEstimate)) +
  geom_line()+
  geom_line(aes(y = firstEstimate), color = "red")+
  ylab("GDP Estimates")

# Facets

ggplot(data = piaac, aes(x = pvnum1, 
                         y = earnmth,
                         color = edlevel3)) +
  geom_point() +
  geom_smooth()
