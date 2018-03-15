# R course day 3
library(tidyverse)
# Your turn 
# install.packages("gapminder")
library(gapminder)
str(gapminder)
summary(gapminder)
gapminder1 <- subset(gapminder, year == "2007")

ggplot(data = gapminder1, 
       aes(x = gdpPercap, y = lifeExp))+
  geom_point(aes(size = pop, color = continent))+
  geom_smooth()+
  scale_x_log10()+
  theme_minimal()
  
gapminder2<-subset(gapminder, year %in% c("1962", "2007"))

ggplot(data = gapminder2, 
       aes(x = gdpPercap, y = lifeExp))+
  geom_point(aes(size = pop, color = continent))+
  scale_x_log10()+
  geom_smooth()+
  facet_wrap(~year)+
  theme_minimal()


# Scales
# rm(piaac)
piaac <- read.csv("http://www.ut.ee/~iseppo/piaacest.csv")
piaac$logincome <- log(piaac$earnhr)


ggplot(data = piaac , aes(x = edlevel3, y= logincome))+
  geom_jitter(alpha = 0.3)+
  theme_minimal()+
  scale_y_continuous(breaks = c(0,2,3), 
                     labels = c("small", "average", "big"))

ggplot(data = piaac , aes(x = edlevel3, y= logincome))+
  geom_jitter(alpha = 0.3)+
  theme_minimal()+
  scale_y_continuous(breaks = c(0,2,3))+
  coord_cartesian(ylim = c(0,2))+ 
#                     labels = c("small", "average", "big"))+
  geom_boxplot()





names(piaac)
# Colorscales and legends
ggplot(data = piaac , aes(x = edlevel3 ))+
  geom_bar(aes(fill=edlevel3))+
  # scale_color_brewer("Education level", palette = "Pastel1")
  scale_fill_manual(values =c("Low" = "red",
                              "Medium" = "blue",
                              "High"= "orange"))


# Your turn

piaac <- subset(piaac, !is.na(children))
ggplot(piaac, aes(x = children ))+
  geom_bar()  +
  facet_wrap(~edlevel3)

ggplot(piaac, aes(x = age, y= earnmth))+
  geom_smooth(aes(color = edlevel3))  +
  facet_wrap(~gender)


# Reordering factor levels

library(forcats)

piaac$edlevel3 <- fct_relevel(piaac$edlevel3, "Low", 
                              "Medium", 
                              "High")

ggplot(piaac, aes(x=children))+
  geom_bar()+
  facet_wrap(~edlevel3)

# statistics in ggplot
averages <- data.frame(edlevel = c("High", "Medium", "Low"), 
                       nrOfPeople = c(10, 20, 30))
averages
ggplot(averages, aes(x = edlevel, y = nrOfPeople))+
  geom_bar(stat = "identity")

# Your turn

earnings <- read.csv("http://www.ut.ee/~iseppo/wagebirthyear.csv")
str(earnings)
 # View(earnings)
earnings$age <- earnings$year - earnings$birthyear
names(earnings)
# Your turn 

ggplot(data = earnings)+
  geom_line(aes(x = age, y = averagewage), color = "blue") +
  geom_line(aes(x = age, y = medianwage), color = "orange") +
  geom_ribbon(aes(x = age ,  ymin = pc25,
                  ymax = pc75), fill = "grey", alpha = 0.3)



p1 <-ggplot(piaac, aes(x=edlevel3, y=earnmth))+
  geom_boxplot()+
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=16))

p2 <-p1 + 
  theme_dark()

# install.packages("cowplot")
library(cowplot)

plot_grid(p1, p2, labels = "AUTO")


# dplyr - a grammar of data manipulation
library(dplyr)
%>%  # Cmd+shift+M/ Ctrl+shift+M

top_n(piaac, 5, earnmth)

# Piping
piaac %>% 
  top_n(5, earnmth)
piaac$logincome <- log(piaac$earnmth)

piaac$logincome

piaac.small <- piaac %>% 
  select(gender:children, logincome, edlevel3)
names(piaac.small)
names(piaac)

piaac.small <- piaac %>% 
  select(starts_with("pv"), seqid)
names(piaac.small)

# Your turn 
piaac.sample1 <- piaac %>% 
  select(starts_with("empl"), ends_with("1"))
names(piaac.sample1)


piaac %>% 
  summarize(average = mean(earnmth, na.rm = T), nrofpeople= n())

results1 <- piaac %>%
  group_by(edlevel3, gender) %>% 
  summarize(average = mean(earnmth, na.rm = T),
            medianincome = median(earnmth, na.rm = T),
            nrofpeople= n()) 

females <- subset(piaac, gender="Female")
summary(females$gender)

females <- piaac %>% 
  filter(gender == "Female")
summary(females$gender)


females <- filter(piaac, gender=="Female")
summary(females$gender)

newtable <- piaac %>% 
  filter(earnmth > 700 & gender == "Male")
summary(newtable$earnmth)

# Your turn 
unique(piaac$health)
piaac.sample2 <- piaac %>% 
  filter(gender=="Female" & health %in% c("Excellent", "Very good") & pvnum1 >= 300)
summary(piaac.sample2)
piaac.sample2 %>% 
  summarize(average = mean(earnmth, na.rm = T)) 

# 
piaac.averages1<- piaac %>% 
  group_by(gender, edlevel3) %>% 
  summarize(averagewage = mean(earnhr, na.rm=T)) %>% 
arrange(desc(averagewage))


piaac.mutate1 <- piaac %>% 
  mutate(sumOfSkills = pvnum1 + pvlit1, halfsum=sumOfSkills/2)
summary(piaac.mutate1$sumOfSkills)
summary(piaac.mutate1$halfsum)

piaac <- piaac %>%
  mutate(relativewage=earnmth/mean(earnmth, na.rm=T))%>%
  ungroup()


head(piaac$relativewage)
names(piaac)
# Your turn 
piaac.sample3 <- piaac %>% 
  group_by(gender, studyarea) %>% 
  filter(age > 30) %>% 
  summarize(averagewage = mean(earnhr, na.rm=T), 
            averagenumeracy = mean(pvnum1, na.rm = T)) %>% 
  arrange(averagenumeracy) %>% 
  readr::write_csv("piaac.sample3.csv")


piaac %>%
  group_by(gender, studyarea)%>%
  filter(age>30)%>%
  summarize(averagewage=mean(earnmth, na.rm=T),
            averagenum=mean(pvnum1, na.rm=T))%>%
  arrange(averagenum) %>%


