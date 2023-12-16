
library(learnr)
library(tidyverse)
library(nycflights13)
library(Lahman)

format(nrow(nycflights13::flights), big.mark = ",")
jan1 <- filter(flights, month == 1, day == 1)
jan1
# Had an arrival delay of two or more hours

filter(flights, arr_delay >= 120)

# Flew to Houston (IAH or HOU)

filter(flights, dest %in% c('IAH','HOU'))

# Were operated by United (UA), American (AA), or Delta (DL)

filter(flights, carrier %in% c('UA','AA','DL'))

# Departed in summer (July, August, and September)

filter(flights, month %in% c(7,8,9))

# Arrived more than two hours late, but didn’t leave late

# Sometimes you can simplify complicated subsetting by remembering De Morgan’s law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y. For example, if you wanted to find flights that weren’t delayed (on arrival or departure) by more than two hours, you could use either of the following two filters:
  
filter(flights, dep_delay == 0 & arr_delay > 120)
filter(flights, !(dep_delay != 0) | !(arr_delay <= 120))

# Were delayed more than an hour, but made up more than 30 minutes in flight

# arr_time
# sched_arr_time

filter(flights, dep_delay > 60 & ((arr_time + 30) < sched_arr_time))

# Departed between midnight and 6am (inclusive)

# dep_time

filter(flights,((dep_time==2400) | (dep_time <= 600)) )

