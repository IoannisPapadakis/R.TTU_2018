# New script file
3+3
4-2
2*3
4/2
6^10
6**2 # another way to take the power
log(12) # takes nat. log
a <- 3
print(a)
a = 3 # works but is not good style
a<- 3+2
a
b <- a+5
2 -> b
b

# Case sensitive
nrofdogs <- 5
nrOFdogs <- 6
rm(a)

nrOfChickens <- 4
nrOfDogs <- 5

nrOfAnimals <- nrOfDogs+nrOfChickens
nrOfAnimals
rm(nrOfDogs)

# Data Vectors

c(3, 4, 5.6, 7)

longvector<- c(3:65)
longvector

# your turn
length <- c(5,6, 8, 10)

c(length, 10, 7)
animal <- c("cat", "dog", "bear", "elephant")
length + 5
length +2
length + c(1,2,3,4)
c(1,2,3,4) + c(1,2,3)
c(1,2,3,4) +  c(1, 2)

# Named vectors
person <- c(name = "Masha", surname ="Mishka")
person
person["surname"]
person["name"]

# Data frames
mydata <- data.frame()
mydata
rm(animal)
rm(length)
mydata$animal
mydata$length
mydata

mydata$animal

mydata$width <- c(3, 3, 1, 1)
mydata
mydata$legthsquared <- mydata$length**2
mydata["length"]
mydata$length
mydata[c("animal", "width")]

# you turn
mydata$volume <- mydata$length*mydata$width
mydata
animalvolume <- mydata[c("animal", "volume")]
animalvolume
rm(mydata$volume) #  this will not work
mydata$volume <- NULL
mydata

# Commands and functions

mean(mydata$length)
?mean
mean(mydata$length,trim = 0.25)
missing <- c(4,5,6, NA)
mean(missing)
mean(missing,na.rm = TRUE)
?read.csv
read.csv("http://www.ut.ee/~iseppo/gdpestimate.csv")
gdp<- read.csv("http://www.ut.ee/~iseppo/gdpestimate.csv")

# Initial overview
summary(gdp)
str(gdp)
head(gdp, n = 2)
tail(gdp, n = 5)
View(head(gdp, n = 10))

# Your turn


gdp$difference <- gdp$firstEstimate - gdp$latestEstimate

summary(gdp)
mean(gdp$difference)

gdp$absdifference <- abs(gdp$difference)
gdp$absdifference
mean(gdp$absdifference)
sd(gdp$absdifference)
cor(gdp$firstEstimate, gdp$latestEstimate)

# 
piaac <- read.csv("http://www.ut.ee/~iseppo/piaac.csv")
str(piaac)
dim(piaac) # Dimensions function
summary(piaac$income)
min(piaac$income, na.rm = T)
max(piaac$income, na.rm = T)

quantile(piaac$income, probs =  c(0.1, 0.5, 0.9),na.rm = TRUE)

# Saving data
write.csv(gdp, file= "gdpnew.csv")

save(gdp, file = "gdpnew.Rdat")
rm(gdp)
load(file = "gdpnew.Rdat")
dput(gdp, file = "gdp.txt")

# Data types
mypet <- "cat"
class(mypet)

mypet <- cat # this will give an error

c <- TRUE
class(c)

class(gdp$date)

a <- 4
a +5
whatisthis <-c(3, 4, "cat", 5)
str(whatisthis)
a<- 4
a +5
a <- as.character(a)
a
a + 5

as.numeric(a)
as.numeric(TRUE)

# Factors
factortest <- read.csv(file = "http://www.ut.ee/~iseppo/factortest.csv")
factortest
head(factortest)
View(factortest)
summary(factortest)
factortest$numbers <- as.numeric(factortest$length)
summary(factortest)
View(factortest)

factortest$correctnr <- as.numeric(as.character(factortest$length))
summary(factortest)
