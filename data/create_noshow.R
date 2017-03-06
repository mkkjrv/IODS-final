#Mikko Järvi 2.3.2017. This is a R script file for IODS final exercise.

library(dplyr)
library(stringr)

#downloading the data from kaggle.com
#https://www.kaggle.com/joniarroba/noshowappointments/downloads/medical-appointment-no-shows.zip

ns <- read.csv("~/IODS-final/data/No-show-Issue-Comma-300k.csv", stringsAsFactors = FALSE)
str(ns)
