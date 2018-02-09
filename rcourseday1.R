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
