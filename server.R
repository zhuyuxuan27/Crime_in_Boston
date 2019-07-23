library(DT)
library(shiny)
library()
shinyServer(function(input, output) {
  output$crime_danger <- renderLeaflet({
    crime_danger=crime %>% 
      filter(danger=='Y') %>% 
      group_by(lat,long) 
    leaflet() %>% 
      addProviderTiles(providers$HikeBike.HikeBike) %>%
      addWebGLHeatmap(lng = crime_danger$long,
                      lat = crime_danger$lat,
                      alphaRange = 3,
                      size = 500)
  })
  output$top5 <- renderPlot({
    crime %>%
      group_by(offense_code_group) %>%
      summarise(total = sum(n())) %>%
      arrange(desc(total)) %>%
      top_n(5) %>%
      ggplot(aes(x = offense_code_group, y = total)) +
      geom_col()+xlab(' Offense Category')+ylab('Total Offense Activity')+ggtitle('High Frequency Offense Activity')
  })
  output$crimearea <- renderPlot({
  crime %>% # Most frequency crime area 案件高发地
    group_by(street) %>%
    summarise(total = sum(n())) %>%
    arrange(desc(total)) %>%
    top_n(5) %>%
    ggplot(aes(x = street, y = total)) + geom_point()+xlab('Crime Street')+
      ylab('Total Crime Activity')+ggtitle('High Frequency Crime Area ')
})
  output$washington_st <- renderLeaflet({
    w_st=crime %>% 
      filter(street=='WASHINGTON ST') %>% 
      group_by(lat,long) 
    leaflet() %>% 
      addProviderTiles(providers$Esri.WorldImagery) %>%
      addWebGLHeatmap(lng = w_st$long,
                      lat = w_st$lat,
                      alphaRange = 3,
                      size = 300)
  })
  output$washington_st_crime <- renderPlot({
    crime %>%
      filter(street=='WASHINGTON ST') %>% 
      group_by(offense_code_group) %>% 
      summarise(total=n()) %>% 
      arrange(desc(total)) %>% 
      top_n(10) %>% 
      ggplot(aes(x=offense_code_group,y=total,group=5))+geom_line()+
      xlab('Crime Activity')+ylab('Total Crime Activity')+
      ggtitle('Washington St Crime Activity')
  })
  output$shooting_area <- renderLeaflet({
    shooting_area=crime %>%
      filter(shooting=='Y') %>%
      group_by(lat,long) 
    leaflet() %>% 
      addProviderTiles(providers$Esri.WorldImagery) %>%
      addWebGLHeatmap(lng = shooting_area$long,
                      lat = shooting_area$lat,
                      alphaRange = 0,
                      size = 500)
  })
  output$shooting_month <- renderPlot({
    crime_shooting %>% # shooting 2016-2018
      group_by(month) %>% 
      summarise(total=n()) %>% 
      arrange(desc(total)) %>% 
      ggplot(aes(x=month,y=total))+geom_line()+
      scale_x_continuous(breaks=seq(1,12,by=1) ) +
      xlab('Month')+ylab('Total Shooting Activity')+
      ggtitle('Monthly Shooting Activity')
  })
  output$shooting_day <- renderPlot({
    crime_shooting %>% 
      group_by(hour) %>% 
      summarise(total=n()) %>%
      arrange(desc(total)) %>% 
      ggplot(aes(x=hour))+geom_line(aes(y=total))+
      xlab('Hour')+ylab('Total Shooting Activity')+
      ggtitle('Daily Shooting Activity')
  })
  output$shooting_week <- renderPlot({
    crime_shooting %>% 
      group_by(day_of_week) %>% 
      summarise(total=n()) %>% 
      ggplot(aes(x=day_of_week,y=total,group=1))+geom_path()+
      xlab('Day')+ylab('Total Shooting Activity')+
      ggtitle('Weekly Shooting Activity')
  })
})

