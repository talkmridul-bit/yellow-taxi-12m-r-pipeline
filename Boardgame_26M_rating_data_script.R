library(tidyverse)
library(readr)

data_raw<- read_csv(file.choose())
data_raw

glimpse(data_raw)

final_boardgame_26M_rating_data<- data_raw %>% distinct() %>%
  mutate(
    rating = as.integer(rating),
    
    ID =  as.integer(ID)
  ) %>% filter(rating > 0 & ID > 0 ,
               !is.na(user),
               !is.na(rating),
               !is.na(ID)) %>%
  group_by(user) %>%
  summarise(
    Avg_Rating = mean(rating),
    
    Unique_games = n_distinct(ID),
    Total_rating = n(),
    .groups = 'drop'
  ) %>% arrange(desc(Total_rating))

final_boardgame_26M_rating_data

write.csv(final_boardgame_26M_rating_data,
          'Boardgame_26M_rating_data.csv',
          row.names = FALSE)

getwd()
