
library(plyr)
library(tidyverse)

#tidyverse

#we start with couple of main verbs: firstone is select()
somedataset %>%
  select(firstvariable, starts_with("whatever")) -> newdataset

#lets read in the data
piaac <- read.csv("http://www.ut.ee/~iseppo/piaacest.csv")

#a quick overview of the data:
names(piaac)
summary(piaac)
head(piaac)
View(piaac)

#and select a subset of variables from it, writing
#the result into a new data object piaacsmall
piaacsmall <- piaac %>%
  select(seqid, age, starts_with("pv"))

#this is actually equivalent to this:
piaacsmall <- select(piaac, seqid, age, starts_with("pv"))
names(piaacsmall)

#filter():

onlymales <- piaac %>%
  filter(gender=="Male")

summary(onlymales)


piaac <- piaac %>%
  filter(!is.na(edlevel3), !is.na(studyarea), !is.na(health))

goodhealth <- piaac %>%
  filter(health %in% c("Excellent", "Very good"))


#group_by() and summarize()
average_numeracy <- piaac %>%
  group_by(gender,studyarea)%>%
  summarize(avnumeracy=mean(pvnum1, na.rm=T))

averagewage <- piaac %>%
  group_by(edlevel3, gender)%>%
  summarize(avwage = mean(earnmth, na.rm = T))
averagewage

averagewage <- piaac %>%
  group_by(edlevel3, gender)%>%
  summarize(avwage = mean(earnmth, na.rm = T),
            pc25 = quantile(earnmth, probs = 0.25, na.rm=T),
            pc75 = quantile(earnmth, probs = 0.75, na.rm=T))%>%
  arrange(avwage)
averagewage

#mutate()

piaac <- piaac %>%
  group_by(gender)%>%
  mutate(relativewage = earnmth / mean(earnmth, na.rm=T))
head(piaac$relativewage)
View(piaac)

piaac



library(dplyr)
piaac %>%
  dplyr::group_by(gender, studyarea)%>%
  dplyr::summarize(avnumeracy = mean(pvnum1, na.rm=T))


#rename()
piaac <- piaac %>%
  rename(PersonId = seqid)
names(piaac)


# install.packages("Rmisc")
library(Rmisc)
averages <- piaac %>%
  dplyr::rename(Literacy = pvlit1, 
         Numeracy = pvnum1, 
         "Problem solving skills" = pvpsl1, 
         Income = earnmth, 
         Education = edlevel3, 
         Health = health) %>%
  filter(!is.na(Health), !is.na(Education), !is.na(Numeracy)) %>%
  group_by(Education) %>%
  summarise(lower = Rmisc::CI(Numeracy)[1], 
            mean = Rmisc::CI(Numeracy)[2], 
            upper = Rmisc::CI(Numeracy)[3])


piaac <- piaac %>%
  rename(Literacy = pvlit1,
         Numeracy = pvnum1,
         "Problem solving skills"=pvpsl1,
         Income = earnmth,
         Education = edlevel3,
         Health = health)

names(piaac)

piaac <- piaac %>%
  dplyr::rename(Literacy = pvlit1, 
                Numeracy = pvnum1, 
                "Problem solving skills" = pvpsl1, 
                Income = earnmth, 
                Education = edlevel3, 
                Health = health) %>%
  filter(!is.na(Health),
         !is.na(Education),
         !is.na(Numeracy))

library(Rmisc)

CI(piaac$Literacy)

averages <- piaac %>%
  group_by(Education)%>%
  summarize(lower=CI(Numeracy)[3],
            mean=mean(Numeracy),
            upper=CI(Numeracy)[1])
averages

names(piaac)
unique(piaac$empl_status)
piaac$employed <- piaac$empl_status == "Employed"
View(piaac)
piaac$employed <- as.numeric(piaac$employed)

ggplot(data=piaac, aes(x=Literacy, y=Income))+
  geom_point()+
  geom_smooth(aes(color=gender))+
  facet_wrap(~Education)


ggplot(data=piaac, aes(x=Numeracy, y=Literacy))+
  geom_point()+
  geom_smooth(aes(color=Education))

ggplot(data=piaac, aes(x=Numeracy, y=employed))+
  geom_point()+
  geom_smooth(aes(color=Education))

ggplot(data=piaac, aes(x=age, y=employed))+
  geom_point()+
  geom_smooth(aes(color=gender))+
  facet_grid(~Education)

levels(piaac$Education)
library(forcats)


piaac$Education <- fct_relevel(piaac$Education,
                               "Low", "Medium", "High")

piaac$Education <- fct_recode(piaac$Education,
                               "Basic"="Low",
                               "Highschool"="Medium")



ggplot(averages, aes(x=mean, y=Education))+
  geom_point(shape=21, size=3, fill="white")+
  theme_minimal()

averages$Education <- fct_reorder(averages$Education,
                                  averages$mean)

averages <- averages %>%
  mutate(fct_reorder(Education, mean))

attach(averages)
Education
detach(averages)
Education

