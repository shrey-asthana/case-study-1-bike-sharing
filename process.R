# FIXING ISSUES
# The data can only be aggregated at the ride-level, which is too granular. 
# need additional columns of data -- such as day, month, year -- that provide 
# additional opportunities to aggregate the data

# adding column for determining 'ride length' in each table.
# ride length is in seconds
# adding column for determining 'day of week' when ride started 

all_trips <- all_trips %>% 
  mutate(ride_length = as.numeric(difftime(ended_at,started_at)))

# adding columns that list date, month, day, year of each ride
# will allow us to aggregate on these levels. earlier, we could only aggregate at ride level

all_trips$date <- as.Date(all_trips$started_at) # default - yyyy-mm-dd
all_trips$month <- format(as.Date(all_trips$date), "%m") # as.Date is needed to ensure datatype is date 
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A") 
all_trips$month_name <- format(as.Date(all_trips$month), "%A")


# inspecting new table all_trips
colnames(all_trips)  #List of column names
nrow(all_trips)  #How many rows are in data frame
dim(all_trips)  #Dimensions of the data frame
head(all_trips)  # first 6 rows of data frame.  Also tail(qs_raw)
str(all_trips)  #See list of columns and data types (numeric, character, etc)
summary(all_trips)  #Statistical summary of data. Mainly for numerics

skim_without_charts(all_trips)

# tripduration shows up as negative, including several hundred rides 
# where company took bikes out of circulation for Quality Control reason


# counting such rows with negative values of ride length
negative_tripdur_cnt <- sum(all_trips$ride_length < 0)
print(negative_tripdur_cnt)

# negative trip_duration turn out to be in 100 observations only. can be removed.


# creating a new version of dataframe(v2) since data is being removed
# company took out some bikes out from the docks named "HQ OR" for quality checks 

# The empty space after the comma tells R to keep all columns.
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ OR" | all_trips$ride_length<0), ]


summary(all_trips_v2)
















