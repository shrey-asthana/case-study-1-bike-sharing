# DESCRIPTIVE ANALYSIS

# creating consolidated overview of tables

overview =  tibble(month = c("jan","feb","mar","apr","may","june",
                             "july","aug","sep","oct","nov","dec"),
                   year = 2022,
                   totalrecords = c(nrow(jan2022),nrow(feb2022),
                                    nrow(mar2022),nrow(apr2022),
                                    nrow(may2022),nrow(june2022),
                                    nrow(july2022),nrow(aug2022),
                                    nrow(sep2022),nrow(oct2022),
                                    nrow(nov2022),nrow(dec2022)))

# arranging months in descending order to see month-wise bike sharing load 

busiest_months <- arrange(overview, desc(totalrecords))
View(busiest_months)


# on ride length
summary(all_trips_v2$ride_length) # median is midpoint number in ascending array of ride lengths


# comparing casual and member users using aggregate() function of stats package
# the expression on the left of the ~ specifies the variable to be aggregated
# The expression on the right of the ~ specifies the grouping variable

aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)


# aggregation via dplyr of tidyverse -- storing tibble as an object 'yearly_stats'
year_stats <- all_trips_v2 %>% 
  group_by(member_casual) %>% 
  summarise(mean = mean(ride_length),
            median = median(ride_length),
            max = max(ride_length),
            min = min(ride_length),
            num_rides = n()) %>% 
  rename(user_type = member_casual)

# avg ride time by each day-of-week -- member vs. casual
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)


# ordering days of the week by converting the day _of_week column as an ordered factor
# ordered() transforms the day_of_week column into an ordered factor. -- now it is <ord> datatype
# this ensures the days are displayed in their natural order (Sunday to Saturday) in results,
# even if they were initially stored differently in the data.
# ordered() is used specifically for categorical variables 
# with a meaningful order, like days of the week or months

all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday",
                                                                       "Tuesday", "Wednesday",
                                                                       "Thursday","Friday",
                                                                       "Saturday"))


# rerunning with the ordered data
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)



# analyzing ridership data by member type and day of week
all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(num_rides = n(),
            avg_duration = mean(ride_length)) %>% 
  arrange(day_of_week)


# analysing rider types based on individual months
month_data <- all_trips_v2 %>%
  mutate(month_name = month(as.numeric(month), label = TRUE, abbr = FALSE)) %>% 
  group_by(month_name,member_casual) %>% 
  summarise(avg_duration = mean(ride_length), min = min(ride_length), max = max(ride_length), num_rides = n()) %>% 
  arrange(month_name)



# VISUALIZING

# num rides by rider type 
all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(num_rides = n(),
            avg_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_week) %>% 
  na.omit() %>% 
  ggplot(aes(x=day_of_week, y = (num_rides/1000), fill = member_casual)) +
  geom_col(position = "dodge") + 
  labs(title = "Number of Rides By Rider Type",
       caption = "N/A values have been omitted",
       fill = "Rider Type",
       x = "Day Of Week",
       y = "Number Of Rides (in thousands)")


# avg duration by rider type
all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(num_rides = n(),
            avg_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_week) %>%
  na.omit() %>% 
  ggplot(aes(x=day_of_week, y = avg_duration , fill = member_casual)) +
  geom_col(position = "dodge") + labs(title = "Average Duration By Rider Type", 
                                      caption = "N/A values have been omitted",
                                      fill = "Rider Type",
                                      x = "Day Of Week",
                                      y = "Number Of Rides")



# Exporting Analysis Files
counts <- all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(num_rides = n(),
            avg_duration = mean(ride_length)) %>% 
  arrange(day_of_week)


write.csv(counts, file = "avg_ride_length.csv")

write.csv(year_stats, file = "yearly_stats.csv")

write.csv(month_data, file = "monthly_data_ride_length.csv")


