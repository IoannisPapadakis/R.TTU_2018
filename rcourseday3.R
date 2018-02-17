# R course day 3

# Your turn 
install.packages("gapminder")
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
