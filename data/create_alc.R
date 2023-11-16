# Name: Building data set again
# Writer: RistoH
# Description: This script takes data from UCI Machine Learning Repository and wrangles it to be eligible for assignment 3. 


#Required packages:
library(tidyverse)

# Read the data: 
mat <- read_delim("data/student-mat.csv",delim = ";")
por <- read_delim("data/student-por.csv",delim = ";")


#Join the data sets:

# Variables to join on
join_vars <- names(mat %>% select(!c("failures", "paid", "absences", "G1", "G2", "G3")))

# Variables to keep in the result
keep_vars <- names(mat %>% select(c("failures", "paid", "absences", "G1", "G2", "G3")))

# Inner join
analysis_data <- inner_join(por,
                     mat,
                     by = join_vars)
str(analysis_data)

# Getting rid of dublicates
alc <- select(analysis_data, all_of(join_vars))

for(col_name in keep_vars) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(analysis_data, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- "first_col"
  }
}

glimpse(alc)

# Additional colums:

alc <- alc %>% 
  mutate(alc_use=(Dalc+Walc)/2,
         high_use=ifelse(alc_use>2,TRUE,FALSE))


#Save the data::
readr::write_csv(alc,"data/alc.csv")


