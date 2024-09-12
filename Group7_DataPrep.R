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

unique(gtd_clean$iyear)
df<-gtd_clean

df$YearColumn <- as.Date(paste0(df$iyear, "-01-01"))
#Extract Decade
df$Decade <- floor(lubridate::year(df$YearColumn) / 10) * 10
tail(df)
# Summarize
decade_summary <- df %>% 
  group_by(Decade) %>% 
  summarize(Total_Value = sum(Value))


##Group 7: Analyze Trends Over Time

##Role 2: Calculate the change in attack frequency over time. 
##Role 3: Visualize trends using a line chart. Development Process: