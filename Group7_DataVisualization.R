# Global Terrorism Database Collaborative Analysis
 
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the dataset
gtd_data <- read.csv("globalterrorismdb_0718dist.csv", 
                     stringsAsFactors = FALSE)

# Basic data exploration
glimpse(gtd_data)


##Role 1: Prepare data by decade. 

gtd_clean<-gtd_data%>%select(iyear, country_txt, attacktype1_txt, nkill)%>%filter(!is.na(nkill))

unique(gtd_clean$attacktype1_txt)
df<-gtd_clean

df$YearColumn <- as.Date(paste0(df$iyear, "-01-01"))
#Extract Decade
df$Decade <- floor(lubridate::year(df$YearColumn) / 10) * 10
tail(df)

##Group 7: Analyze Trends Over Time

##Student 2: Calculating the change in attack frequency over time. 

# Summarize
decade_summary <- df %>% 
  group_by(Decade) %>% 
  summarize(Total_nkill = sum(nkill))


##Role 3: Visualize trends using a line chart. 

library(ggplot2)

LineGraph<-decade_summary %>%
  ggplot(mapping = aes(
    x = Decade,
    y = Total_nkill)) +
  geom_line() +
  theme_classic()

LineGraph


##Role 4: Improve the plot:
library(tidyverse)
?geom_line
?geom_point


decade_summary %>%
  ggplot(mapping = aes(x = Decade,
    y = Total_nkill)) +
  geom_line(aes(y=Total_nkill),color = 'green', size=4) +
  geom_point(aes(y=Total_nkill),color='red', size=4.5)+
  #theme_classic()+
    theme_bw() +
    theme(axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank()) 
