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
summary(all_trips_v2$ride_length)


# ordering days of the week by converting the day _of_week column as an ordered factor
# ordered() transforms the day_of_week column into an ordered factor. -- now it is <ord> datatype
# this ensures the days are displayed in their natural order (Sunday to Saturday) in results,
# even if they were initially stored differently in the data.

all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday",
                                                                       "Tuesday", "Wednesday",
                                                                       "Thursday","Friday",
                                                                       "Saturday"))


# using dplyr of tidyverse 

# aggregating yearly stats by member type, storing tibble as an object 'year_stats'
year_stats <- all_trips_v2 %>% 
  group_by(member_casual) %>% 
  summarise(mean = mean(ride_length),
            median = median(ride_length),
            max = max(ride_length),
            min = min(ride_length),
            num_rides = n()) %>% 
  rename(user_type = member_casual)


# aggregating ridership data by member type and day of week, storing in 'counts' tibble
counts <- all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(num_rides = n(),
            avg_duration = mean(ride_length)) %>% 
  arrange(day_of_week)

# aggregating rider types based on individual months
month_data <- all_trips_v2 %>%
  mutate(month_name = month(as.numeric(month), label = TRUE, abbr = FALSE)) %>% 
  group_by(month_name,member_casual) %>% 
  summarise(avg_duration = mean(ride_length), min = min(ride_length), max = max(ride_length), num_rides = n()) %>% 
  arrange(month_name)



# VISUALIZING

# visualising avg duration by rider type
counts %>%
  na.omit() %>% 
  ggplot(aes(x=day_of_week, y = avg_duration , fill = member_casual)) +
  geom_col(position = "dodge") + labs(title = "Average Duration By Rider Type", 
                                      caption = "N/A values have been omitted",
                                      fill = "Rider Type",
                                      x = "Day Of Week",
                                      y = "Average Duration")


# visualising num rides by rider type 
counts %>% 
  arrange(member_casual, day_of_week) %>% 
  na.omit() %>% 
  ggplot(aes(x=day_of_week, y = (num_rides/1000), fill = member_casual)) +
  geom_col(position = "dodge") + 
  labs(title = "Number of Rides By Rider Type",
       caption = "N/A values have been omitted",
       fill = "Rider Type",
       x = "Day Of Week",
       y = "Number Of Rides (in thousands)")


# EXPORTING ANALYSIS FILES

write.csv(counts, file = "avg_ride_length.csv")

write.csv(year_stats, file = "yearly_stats.csv")

write.csv(month_data, file = "monthly_data_ride_length.csv")


