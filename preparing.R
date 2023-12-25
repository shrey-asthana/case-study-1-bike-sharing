# checking column names of each file
colnames(jan2022)
colnames(feb2022)
colnames(mar2022) 
colnames(apr2022)
colnames(may2022)
colnames(june2022) 
colnames(july2022)
colnames(aug2022)
colnames(sep2022) 
colnames(oct2022)
colnames(nov2022)
colnames(dec2022) 

# column names match perfectly 

# inspecting the dataframes and looking for inconguencies
str(jan2022)
str(feb2022)
str(mar2022) 
str(apr2022)
str(may2022)
str(june2022) 
str(july2022)
str(aug2022)
str(sep2022) 
str(oct2022)
str(nov2022)
str(dec2022) 

# the data types of the respective columns are same in each table 

# now we can use a command to join them into one file
# binding rows of each table to form one big data frame using bind_rows() in dplyr

all_trips <- bind_rows(jan2022, feb2022, mar2022, apr2022, may2022, june2022, 
                       july2022, aug2022, sep2022, oct2022, nov2022, dec2022)

# removing columns not required for analysis
# start_lat, start_lng, end_lat, end_lng

all_trips <- all_trips %>% select(-c(start_lat,start_lng,end_lat,end_lng))

