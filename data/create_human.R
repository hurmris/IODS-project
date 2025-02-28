library(readr)
library(tidyverse)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#Structure:
str(hd)
str(gii)

#Summaries with skimr package:
skimr::skim(hd)
skimr::skim(gii)

#Then do this in different order than in the assignment because it is more convenient:

#Start by joining 
human <- gii %>% inner_join(hd,by="Country")

#Rename variables:
human <- human %>% 
  rename(
    "GNI" = "Gross National Income (GNI) per Capita",
    "Life.Exp" = "Life Expectancy at Birth",
    "Edu.Exp" = "Expected Years of Education",
    "Mat.Mor" = "Maternal Mortality Ratio",
    "Ado.Birth" = "Adolescent Birth Rate",
    
    # Empowerment
    "Parli.F" = "Percent Representation in Parliament",
    "Edu2.F" = "Population with Secondary Education (Female)",
    "Edu2.M" = "Population with Secondary Education (Male)",
    "Labo.F" = "Labour Force Participation Rate (Female)",
    "Labo.M" = "Labour Force Participation Rate (Male)")

# Create the two new variables:

human <- human %>% 
  mutate(Edu2.FM = Edu2.F / Edu2.M,
         Labo.FM = Labo.F / Labo.M)

# Save
readr::write_csv(x = human,file = "data/human.csv")

# Read 
human <- readr::read_csv("data/human.csv")
 
# Explore structure:
str(human)

#Dataset originates from the United Nations Development Programme. 
# Full description of the data set can be found here: https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf
#Variables are renamed as already showed above

# Exclude unneeded variables:

human <- human %>% 
  select("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F") %>% 
  na.omit() %>% 
  filter(!(Country %in% c("Arab States",
                         "East Asia and the Pacific",
                         "Europe and Central Asia",
                         "Latin America and the Caribbean",
                         "South Asia",
                         "Sub-Saharan Africa",
                         "World")))
  
#Write over the existing file: 

readr::write_csv(x = human,file = "data/human.csv")












