install.packages("tidyverse")
library(tidyverse) # for data wrangling
library(lubridate) # for date functions
library(ggplot2)   # for visualisation

install.packages("readr")
library(readr)

install.packages("skimr")
library(skimr)

getwd()

# setting working directory to simplify calls to data
setwd("D:/Work/Data Analytics/Case Studies/Bike Sharing/dataset") 


# reading all tables in Rstudio
jan2022 <- read_csv("202201-divvy-tripdata.csv",col_names = TRUE)

feb2022 <- read_csv("202202-divvy-tripdata.csv",col_names = TRUE)

mar2022 <- read_csv("202203-divvy-tripdata.csv",col_names = TRUE)

apr2022 <- read_csv("202204-divvy-tripdata.csv",col_names = TRUE)

may2022 <- read_csv("202205-divvy-tripdata.csv",col_names = TRUE)

june2022 <- read_csv("202206-divvy-tripdata.csv",col_names = TRUE)

july2022 <- read_csv("202207-divvy-tripdata.csv",col_names = TRUE)

aug2022 <- read_csv("202208-divvy-tripdata.csv",col_names = TRUE)

sep2022 <- read_csv("202209-divvy-publictripdata.csv",col_names = TRUE)

oct2022 <- read_csv("202210-divvy-tripdata.csv",col_names = TRUE)

nov2022 <- read_csv("202211-divvy-tripdata.csv",col_names = TRUE)

dec2022 <- read_csv("202212-divvy-tripdata.csv",col_names = TRUE)
