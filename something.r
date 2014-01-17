# sample project or whatever

library(ggplot2)
library(reshape2)
library(plyr)
library(stargazer)


#------------
# Read data
#------------
medals <- read.csv("http://andhs.co/olympics")

#----------------
# Medal winners
#----------------
# Age of medal winners
fig1 <- ggplot(medals, aes(x=Age))
fig1 <- fig1 + geom_bar(stat="bin", binwidth=1) + 
  labs(x="Age", y="Count", title="Age of Olympic medal winners, 2000-2012\n")
ggsave(plot=fig1, filename="figure_1.pdf", width=7, height=5, units="in")

