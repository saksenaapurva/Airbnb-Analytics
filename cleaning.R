install.packages("corrplot")
install.packages("tidyr")
install.packages("dplyr")
library(dplyr)
library(plyr)
library(stringr)
library(ggplot2)
library(corrplot)
library(tidyr)
source("http://www.sthda.com/upload/rquery_cormat.r")


#1) Reading the dataset from csv
listings2 <- read.csv("listings1.csv", header = TRUE)

#2) Price cleaning and formatting. Stripping the dollar sign and the commas in price.
listings2$price<-gsub("$","",listings2$price,fixed=TRUE)
listings2$price<-gsub(",","",listings2$price,fixed=TRUE)
listings2$price <- as.numeric(as.character(listings2$price))
#Remove { from the amenities amenities
listings2$amenities<-gsub("{","",listings2$amenities,fixed=TRUE)
#Remove } from the amenities amenities
listings2$amenities<-gsub("}","",listings2$amenities,fixed=TRUE)
#Remove inverted commas from amenities
listings2$amenities<-gsub('"',"",listings2$amenities,fixed=TRUE)

#Count frequency of amenties in the dataset
data.frame(table(unlist(strsplit(tolower(listings2$amenities), ","))))
value1 <- "Wireless Internet"


#Create a variable containing boolean values with pattern matching for "Wireless Internet"
listings2["amenities_wireless_internet"] <- grepl(value1,listings2$amenities)

#Convert price to numeric since it is in character
listings2$price <- as.numeric(as.character(listings2$price))
