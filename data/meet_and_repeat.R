#Description: This script wrangles the two data sets ( BPRS and RATS) and saves them for analysis
#Author: RH
#Date: today

library(tidyverse)

# RATS ----

##Read the data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

str(RATS)
#Id= Identificator for rat
#group= treatment vs control diet
#WD## = rats body weight at week #

##Convert to factors 
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

##Pivot longer
RATSL <- RATS %>% 
  pivot_longer(cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  
  mutate(Time = as.integer(substr(WD,3,4))) %>% 
  arrange(Time)

glimpse(RATSL)
summary(RATSL)

# RATSL is now longer format version of RATS. We convert it to panel format in order to use it in longitudial analysis.

#Save:
readr::write_csv(RATSL,"data/rats.csv")

# BPRS ----
# The task here is very similar to above.
# Convert the data to long format to use it in random effects model.
# In the wide format weekly scrores are as variables.
# In long these are converted to pairs of bprs and week variable value pairs. 

#Read data:
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

#Assign characters to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Pivot to long form format
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) 

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Glimpse:
glimpse(BPRSL)

#Save
readr::write_csv(BPRSL,"data/bprs.csv")

