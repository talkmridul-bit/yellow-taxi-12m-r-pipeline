library(tidyverse)
library(readr)

data_raw<- read_csv(file.choose())
data_raw

glimpse(data_raw)

final_taxi_12M_data <- data_raw %>% distinct() %>%
  mutate(
    VendorID = as.integer(VendorID),
    passenger_count = as.integer(passenger_count),
    trip_distance = as.numeric(trip_distance),
    fare_amount = as.numeric(fare_amount),
    tip_amount = as.numeric(tip_amount),
    tolls_amount = as.numeric(tolls_amount),
    total_amount = as.numeric(total_amount)
    
  ) %>% filter(passenger_count > 0 & trip_distance > 0 & fare_amount > 0 &
               tip_amount >= 0 & tolls_amount >= 0 & total_amount > 0 &
                 !is.na(trip_distance),
               !is.na(fare_amount), fare_amount > 0 ,fare_amount <1000,
               !is.na(tolls_amount),tolls_amount >=0, 
               !is.na(total_amount), total_amount > 0, total_amount < 1000
               ) %>%
  group_by(VendorID) %>% 
  summarise(
    Total_Revenue = sum(total_amount,na.rm = TRUE),
    Total_passenger_count = sum(passenger_count,na.rm = TRUE),
    Total_fare_amount = sum(fare_amount, na.rm = TRUE),
    Total_tip_amount = sum(tip_amount, na.rm = TRUE),
    Total_toll_amount = sum(tolls_amount,na.rm = TRUE),
    Avg_fare_amount = mean(fare_amount,na.rm = TRUE),
    Avg_Revenue  = mean(total_amount, na.rm=TRUE),
    Total_Trips = n(),
    .groups = 'drop'
  ) %>% arrange(desc(Total_Trips))

final_taxi_12M_data

write.csv(final_taxi_12M_data,
          'Yellow_taxi_12M_trip_data.csv',
          row.names = FALSE)
getwd()
