#Author: RistoH
#Date:Nov.3.2023
#Info: This script takes the learning data, wrangles is and saves!

#Required packages
library(tidyverse)
library(skimr)

#Read data

lrn14 <- readr::read_delim("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt",delim = "\t")

#Structure:
class(lrn14) #We have data frame
skim(lrn14) #We notice that all are characters and there is no missing values


#Create analysis data set
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

