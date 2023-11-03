#Author: RistoH
#Date: Nov.3.2023
#Description: This script takes the learning data, wrangles is and saves!

#Required packages
library(tidyverse)
library(skimr)


# 1. Data wrangling ------
#Read data

data <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt",sep = "\t",header = TRUE)

#Structure:
str(analysis_data)
class(data) #We have data frame
skim(data) #We notice that all are characters and there is no missing values

#Create analysis data set
data$attitude <- as.numeric(data$Attitude) / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
data$deep <- rowMeans(data[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
data$surf <- rowMeans(data[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
data$stra <- rowMeans(data[, strategic_questions])
learning2014 <- data[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

#Filter zero points away
analysis_data <- learning2014 %>% 
  filter(Points != 0)

#Save the data
write_csv(analysis_data,"data/learning2014.csv")

rm(analysis_data)
# Show how to read
analysis_data <- read_csv("data/learning2014.csv")
str(analysis_data)
head(analysis_data)

     