# Import library
library(readr)
library(ggplot2)
library(dplyr)

# Import datasets
data <- read_csv("FireCausesJakarta.csv")
head(data)

# unique values
unique(data[c("year")])
unique(data[c("region")])
unique(data[c("causes")])

# Change data type
data$year <- as.factor(data$year)
data$region <- as.factor(data$region)
data$causes <- as.factor(data$causes)
head(data)

# Check missing data
sum(is.na(data))

# Make yearly aggregated data
yearly <- aggregate(number~year, data, sum)
ggplot(yearly, aes(x=year,y=number,group=1)) +
  geom_line(stat='identity',color='red',size=1.5) + 
  geom_point() +
  geom_text(aes(label=number),hjust=1.2, color="black", size=6, parse=TRUE) +
  ggtitle("Number of Fire Incidents In Jakarta \n 2015-2020") +
  labs(x='Year',y='Total') +
  theme(plot.title = element_text(hjust = 0.5,size=20,face='bold'),text = element_text(size=20))

# Make trend plot each year by causes
trend <- data %>%
  group_by(year,causes) %>%
  summarise(number = sum(number))

ggplot(trend,aes(x = year, y = number, colour = causes, group = causes)) +
  geom_line(size=1.2) +
  ggtitle("Number of Fire Incidents in Jakarta \n2015-2020") +
  labs(x='Year',y='Total') +
  theme(plot.title = element_text(hjust = 0.5,size=15,face='bold'),text = element_text(size=15)) +
  scale_colour_brewer(palette="Set1") 

# Make Bar Chart causes of fire incidents
causes <- aggregate(number~causes, data, sum)
ggplot(causes, aes(x=reorder(causes,number),y=number)) +
  geom_bar(stat="identity", fill='steelblue') +
  geom_text(aes(label=number),hjust=1, color="black", size=6, parse=TRUE) +
  ggtitle("Number of Fire Incidents in Jakarta \nby Cause") +
  labs(x='Cause',y='Total') +
  theme(plot.title = element_text(hjust = 0.5,size=15,face='bold'),text = element_text(size=15)) +
  coord_flip()

# Make Bar chart cause of fire incident by region
region <- aggregate(number~region,data,sum)
ggplot(region, aes(x=reorder(region,number),y=number)) +
  geom_bar(stat="identity", fill='steelblue') +
  geom_text(aes(label=number),hjust=1, color="black", size=6, parse=TRUE) +
  ggtitle("Number of Fire Incidents in Jakarta \nby Region") +
  labs(x='Region',y='Total') +
  theme(plot.title = element_text(hjust = 0.5,size=15,face='bold'),text = element_text(size=15)) +
  coord_flip()

# Bar chart Number of fire incidents in Jakarta by Cause each year
ggplot(data, aes(x=causes,y=number,fill=causes)) +
  geom_bar(stat="identity") +
  ggtitle("Number of Fire Incidents in Jakarta Based on Cause \nSeperated by Year") +
  labs(x='Cause',y='Total') +
  theme(plot.title = element_text(hjust=0.5,size=15,face='bold'),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1),text = element_text(size=15)) + 
  facet_wrap(~year)

# Bar chart number of fire incidents in Jakarta by Cause each region
ggplot(data, aes(x=causes,y=number,fill=causes)) +
  geom_bar(stat="identity") +
  ggtitle("Number of Fire Incidents in Jakarta Based on Cause \nSeperated by Region") +
  labs(x='Cause',y='Total') +
  theme(plot.title = element_text(hjust=0.5,size=15,face='bold'),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1),text = element_text(size=15)) + 
  facet_wrap(~region) 

# Bar chart number of fire incidents in Jakarta by region each year
ggplot(data, aes(x=region,y=number,fill=region)) +
  geom_bar(stat="identity") +
  ggtitle("Number of Fire Incidents in Jakarta Based on Region \nSeperated by Year") +
  labs(x='Region',y='Total') +
  theme(plot.title = element_text(hjust=0.5,size=15,face='bold'),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1),text = element_text(size=15)) + 
  facet_wrap(~year) 