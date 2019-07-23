## global.R ##
library(dplyr)
library(shiny)
library(ggplot2)
library(tidyverse)
library(tidyr)
library(data.table)
library(leaflet)
library(leaflet.extras)
crime=fread(file='crime.csv')


crime_shooting=crime %>% 
  filter(between(year,'2016','2017'),shooting=='Y')
