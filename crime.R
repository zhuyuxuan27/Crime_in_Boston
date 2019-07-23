library(dplyr)
library(tidyverse)
library(tibble)
library(leaflet)
library(leaflet.extras)
#library(maps)
#library(tmap)
# nrow(crime1)
# !complete.cases(crime1)
# sum(is.na(crime1))


crime=read.csv('crime.csv',header = T,stringsAsFactors = F)
# crime=na.omit(crime)
crime_shooting=crime %>% 
  filter(between(year,'2016','2017'),shooting=='Y')
# names(crime)=tolower(names(crime)) #小写
# crime=crime %>%  #去除outliers
#   filter(lat!=-1,long!=-1)
#write.csv(crime,'crime1.csv')
 View(crime)
crime$V1=NULL
# # colnames(crime)
# # nrow(crime) 


# crimelocation=crimeomit %>% 
#   filter(lat>=40&lat<=50,long>=-80&long<=-60)
#   filter(between(lat,40,43),between(long,-80,-60))

year_2018=crime %>% 
  filter(shooting=='Y') %>% 
  group_by(location)

nrow(year_2018)

leaflet() %>% 
  addTiles() %>% 
  addCircles(lat = year_2018$lat, 
             lng = year_2018$long,
             popup = "Boston") 



crime %>%  # Most frequency crime Top 5 案件频率最高前5
  group_by(offense_code_group) %>% 
  summarise(total=sum(n())) %>% 
  arrange(desc(total)) %>% 
  top_n(20)

crime %>%  # 案件频率最高前5
  group_by(offense_code_group) %>% 
  summarise(total=sum(n())) %>% 
  arrange(desc(total)) %>% 
  top_n(5) %>% 
  ggplot(aes(x=offense_code_group,y=total))+
  geom_col(aes(fill='red'))










crime %>% # Most frequency crime area 案件高发地
  group_by(street) %>% 
  summarise(total=sum(n())) %>% 
  arrange(desc(total)) %>% 
  top_n(20)

crimearea=crime %>% # Most frequency crime area 案件高发地
  group_by(street) %>% 
  summarise(total=sum(n())) %>% 
  arrange(desc(total)) %>% 
  top_n(5) %>% 
  ggplot(aes(x=street,y=total))+geom_point()





clean=function(col){
    crime%>%
    group_by(col) %>%
    summarise(total=sum(n())) %>%
    top_n(5)
}








crime %>%  #2018shooting zone 枪击事件区
  filter(year==2018&shooting =='Y') %>% 
  group_by(shooting,district)%>% 
  summarise(total=n()) %>% 
  arrange(desc(total)) %>% 
  top_n(5)






####NOW !~~~~####
shooting_area=crime %>% # shooting area 
  filter(shooting=='Y') %>%
  group_by(lat,long)
  # summarise(n=n_distinct(lat,long)) 
# leaflet() %>%
#   addTiles() %>%
#   addCircleMarkers(lat = centrest$lat,
#              lng = centrest$long,
#              popup = "Boston")

####Heatmap####
leaflet() %>% 
   # addTiles() %>% 
  addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
  addWebGLHeatmap(lng =  shooting_area$long,
                  lat = shooting_area$lat,
                  alphaRange = 0,
                  size = 500)

addWebGLHeatmap()

#shooting 2018####
shooting_2018=crime %>% # shooting 2018  
  filter(year=='2018',shooting=='Y') %>%
  group_by(lat,long) 
leaflet() %>% 
  addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
  addWebGLHeatmap(lng = shooting_2018$long,
                  lat = shooting_2018$lat,
                  alphaRange = 0,
                  size = 500)

#shooting 2017####
shooting_2017=crime %>% # shooting 2017  
  filter(year=='2017',shooting=='Y') %>%
  group_by(lat,long) 
leaflet() %>% 
  addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
  addWebGLHeatmap(lng = shooting_2017$long,
                  lat = shooting_2017$lat,
                  alphaRange = 0,
                  size = 500)



####MAp####
leaflet_andrew <- leaflet() %>% addPolygons(data = boston,
                                                 fillColor = heat.colors(6, alpha = 1),
                                                 stroke = FALSE) 
leaflet_andrew
boston <- map("state", fill = TRUE, plot = FALSE,
                 region = c('Massachusetts'))
boston_city = map.cities(x = us.cities, country = 'MA')

# 
# 
# C11=crime %>% 
#   filter(district=='C11') %>% 
#   group_by(lat,long) %>% 
#   summarise(n=n_distinct(lat,long))



crime %>%  #2018shooting zone 枪击事件区
  filter(year==2018&shooting =='Y') %>% 
  group_by(shooting,district)%>% 
  summarise(total=n()) %>% 
  arrange(desc(total)) %>% 
  top_n(5) %>% 
  ggplot(aes(x=district,y=total))+geom_point()









crimecategory=crime %>% # crime type 犯罪类型
  group_by(offense_code_group) %>% 
  summarise(n=n_distinct(offense_code_group))
View(crimecategory)
write.table(x=crimecategory,file = 'crimecategory.doc')

crime %>%  #crime weekday 犯罪日期
  group_by(day_of_week) %>%
  summarise(total=n()) %>% 
  arrange(desc(total))
#shooting_day####
crime_shooting %>% 
  group_by(day_of_week) %>% 
  summarise(total=n()) %>% 
  ggplot(aes(x=day_of_week,y=total,group=1))+geom_path()+
  xlab('Day')+ylab('Total Shooting Activity')+
  ggtitle('Weekly Shooting Activity')

crime_shooting %>% 
  group_by(street) %>% 
  summarise(total=n()) %>% 
  arrange(desc(total))
#shooting_washington####
shooting_washington=crime_shooting %>% 
  filter(street=='WASHINGTON ST ') %>% 
  group_by(lat,long) %>% 
  summarise(n=n_distinct(lat))
View(shooting_washington)
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addWebGLHeatmap(lng = shooting_washington$long,
                  lat =shooting_washington$lat,
                  alphaRange = 1,
                  size = 300)

 
crime %>% # crime month犯罪月份 
  group_by(month) %>%
  summarise(total=n()) %>% 
  arrange(desc(total))

#Shooting month####
crime_shooting=crime %>% 
  filter(between(year,'2016','2017'),shooting=='Y')
crime_shooting %>% 
  group_by(month) %>%
  summarise(total=n()) %>% 
  arrange(desc(total))



crime %>%  # shooting crime 枪击事件的案件
  select(shooting,offense_code_group) %>% 
  filter(shooting=='Y') %>%
  group_by(offense_code_group,shooting) %>% 
  summarise(total=n()) %>% 
  arrange(desc(total))

crime %>% # crime hour 犯罪时间
  group_by(hour) %>% 
  summarise(total=n()) %>%
  arrange(desc(total))

crime %>% 
  group_by(offense_code_group,hour) %>% 
  summarise(total=n())

#shooting_hour####
crime_shooting %>% 
  group_by(hour) %>% 
  summarise(total=n()) %>%
  arrange(desc(total)) %>% 
  ggplot(aes(x=hour))+geom_line(aes(y=total))+
  xlab('Hour')+ylab('Total Shooting Activity')+
  ggtitle('Daily Shooting Activity')
  


crime=crime %>%  # Danger crime 危险的犯罪行为
  mutate(danger=case_when(
    offense_code_group == 'Arson' ~'Y',
    offense_code_group == 'Aggravated Assault' ~'Y',
    offense_code_group == 'Assembly or Gathering Violations' ~'Y',
    offense_code_group == 'Drug Violation' ~'Y',
    offense_code_group == 'Explosives' ~'Y',
    offense_code_group == 'Harassment' ~'Y',
    offense_code_group == 'HUMAN TRAFFICKING' ~'Y',
    offense_code_group == 'Manslaughter' ~'Y',
    offense_code_group == 'Missing Person Located' ~'Y',
    offense_code_group == 'Missing Person Reported' ~'Y',
    offense_code_group == 'Robbery' ~'Y',
    offense_code_group == 'Simple Assault' ~'Y',
    
  ))




# leaflet() %>% 
#   addWebGLHeatmap(lng =  ~ long,
#                   lat =  ~ lat,
#                   size = 60000)


#shooting month ####
shooting_month=crime_shooting %>% # shooting 2016-2018
  group_by(month) %>% 
  summarise(total=n()) %>% 
  arrange(desc(total)) %>% 
  ggplot(aes(x=month))+geom_line(aes(y=total))+
  xlab('Month')+ylab('Total Shooting Activity')+
  ggtitle('Monthly Shooting Activity')





leaflet() %>% 
  addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
  addWebGLHeatmap(lng = shooting_2018$long,
                  lat = shooting_2018$lat,
                  alphaRange = 0,
                  size = 500)

#washington st####
w_st=crime %>% 
  filter(street=='WASHINGTON ST') %>% 
  group_by(lat,long) 
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addWebGLHeatmap(lng = w_st$long,
                  lat = w_st$lat,
                  alphaRange = 3,
                  size = 300)


#washington st crime####
crime %>%
  filter(street=='WASHINGTON ST') %>% 
  group_by(offense_code_group) %>% 
  summarise(total=n()) %>% 
  arrange(desc(total)) %>% 
  top_n(10) %>% 
  ggplot(aes(x=offense_code_group,y=total,group=5))+geom_line()+
  xlab('Crime Activity')+ylab('Total Crime Activity')+
  ggtitle('Washington St Crime Activity')

#danger ####
crime_danger=crime %>% 
  filter(danger=='Y') %>% 
  group_by(lat,long) 
  leaflet() %>% 
  addProviderTiles(providers$HikeBike.HikeBike) %>%
  addWebGLHeatmap(lng = crime_danger$long,
                  lat = crime_danger$lat,
                  alphaRange = 3,
                  size = 500)
  

