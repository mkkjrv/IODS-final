#Mikko Järvi 2.3.2017. This is a R script file for IODS final exercise.

library(dplyr)
library(stringr)
library(lubridate)

#downloading the data from kaggle.com
#https://www.kaggle.com/joniarroba/noshowappointments/downloads/medical-appointment-no-shows.zip

ns <- read.csv("~/IODS-final/data/No-show-Issue-Comma-300k.csv", stringsAsFactors = FALSE)
str(ns)

#Variables like integers and characters are not suitable. We need to change the variables as follows
ns$Gender <- factor(ns$Gender, c("M", "F")) 
ns$AppointmentRegistration <- ymd_hms(ns$AppointmentRegistration)
ns$ApointmentData <- ymd_hms(ns$ApointmentData)
ns$DayOfTheWeek <- factor(ns$DayOfTheWeek,
                          levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday" , 
                                     "Saturday", "Sunday"))
ns$Status <- factor(make.names(ns$Status))
ns$Diabetes <- as.logical(ns$Diabetes)
ns$Alcoolism <- as.logical(ns$Alcoolism)
ns$HiperTension <- as.logical(ns$HiperTension)
ns$Handcap <- as.logical(ns$Handcap)
ns$Smokes <- as.logical(ns$Smokes)
ns$Scholarship <- as.logical(ns$Scholarship)
ns$Tuberculosis <- as.logical(ns$Tuberculosis)
ns$Sms_Reminder <- as.logical(ns$Sms_Reminder)
summary(ns)

#there seems to be some strange values in *Age* and in *AwaitingTime*
range(ns$Age)
sum(ns$Age<0)

#negative values in variable age are errors, we don't delete them but make them positive
ns$Age <- abs(ns$Age)

#we think also that waiting time as a positive value 
range(ns$AwaitingTime)
ns$AwaitingTime <- abs(ns$AwaitingTime)

#extracting time stamps (registration) to year, month, day, weekday
ns <- mutate(ns, RegYear = factor(format(ns$AppointmentRegistration,'%Y')))
ns <- mutate(ns, RegMonth = factor(format(ns$AppointmentRegistration,'%m')))
ns <- mutate(ns, RegDay = factor(format(ns$AppointmentRegistration,'%d')))
ns <- mutate(ns, RegWeekDay = factor(format(ns$AppointmentRegistration, '%A')))
                                           
#extracting time stamps (appointment) to year, month, day, weekday, hour
ns <- mutate(ns, AppYear = factor(format(ns$ApointmentData,'%Y')))
ns <- mutate(ns, AppMonth = factor(format(ns$ApointmentData,'%m')))
ns <- mutate(ns, AppDay = factor(format(ns$ApointmentData,'%d')))
ns <- mutate(ns, AppWeekDay = factor(format(ns$ApointmentData, '%A')))

#cleaning names of columns
colnames(ns)[4] <- "AppointmentData"
colnames(ns)[8] <- "Alcoholism"
colnames(ns)[9] <- "HipTension"
colnames(ns)[10] <- "Handicap"
colnames(ns)[15] <- "WaitingTimeDays"

##check working directory and save the "noshow.txt" to the data folder
getwd()
summary(ns)
str(ns)
dim(ns)
write.table(ns, file="noshow.txt", sep = "\t")

#checking that export was appropriate
#sometable <- read.table("noshow.txt", header = TRUE, sep = "\t")
#str(sometable)

