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

#--------------
# Gold medals
#--------------
# Top gold-winning countries
top.gold <- ddply(medals, ~ Country, summarize, Gold=sum(Gold))

# Sort countries by number of gold medals
top.gold <- top.gold[order(top.gold$Gold, decreasing=TRUE), ]
top.gold$Country <- factor(top.gold$Country, levels=top.gold$Country, ordered=TRUE)

# Plot
fig2 <- ggplot(top.gold[1:10,], aes(x=Country, y=Gold))
fig2 <- fig2 + geom_bar(stat="identity") + labs(x=NULL, y="Gold Medals", title="Gold Medals (2000-2012)\n")
ggsave(plot=fig2, filename="figure_2.pdf", width=7, height=5, units="in")

#-------------
# All medals
#-------------
# All medals by country
top.countries <- ddply(medals, ~ Country, summarize, 
                       Gold=sum(Gold),
                       Silver=sum(Silver),
                       Bronze=sum(Bronze),
                       Total=sum(Total))  # Only get the total for sorting; drop later
top.countries <- top.countries[order(top.countries$Total, decreasing=TRUE), ]
top.countries$Country <- factor(top.countries$Country, levels=top.countries$Country, ordered=TRUE)

# Create an RTF summary table
output <- RTF("most-medals.docx", width=8.5, height=11)
addText(output, "Table 1: ", bold=TRUE)
addText(output, "Top medal-earning countries, 2000-2012")
addNewLine(output)
addTable(output, top.countries[1:10,], font.size=10, row.names=F, NA.string="-")
done(output)

