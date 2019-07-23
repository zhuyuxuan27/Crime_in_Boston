




library(shinydashboard)


shinyUI(dashboardPage(
  dashboardHeader(title = 'Crime in Boston'),
  dashboardSidebar(
    sidebarUserPanel(name = 'Yuxuan',
                     subtitle = 'Boston'),
    sidebarMenu(
      menuItem('Boston',
        tabName = 'boston',
        icon = icon('map')
      ),
      menuItem(
        text = 'Map',
        tabName = 'map',
        icon = icon('map')
      ),
      menuItem(
        text = 'Crime Top 5',
        tabName = 'crimetop5',
        icon = icon("database")
      ),
      menuItem(
        text = 'Crime Area',
        tabName = 'crimearea',
        icon = icon('database')
      ),
      menuItem(
        text = 'Washington ST',
        tabName = 'washington_st',
        icon = icon('map')
      ),
      menuItem(
        text = 'Washington ST Crime Activity',
        tabName = 'washington_st_crime',
        icon = icon('database')
      ),
      menuItem(
        text = 'Shooting Area',
        tabName = 'shooting_area',
        icon = icon('map')
      ),
      menuItem(
        text = 'Shooting Month',
        tabName = 'shooting_month',
        icon = icon('database')
      ),
      menuItem(
        text = 'Shooting Week',
        tabName = 'shooting_week',
        icon = icon('database')
      ),
      menuItem(
        text = 'Shooting Day',
        tabName = 'shooting_day',
        icon = icon('database')
      )
    ) 
  ),
  dashboardBody(tabItems(
    tabItem(tabName = 'boston',
            fluidRow(box(
            img(src='https://d279m997dpfwgl.cloudfront.net/wp/2018/01/lance-anderson-393963-1000x667.jpg')
            ))),
    tabItem(tabName = 'map',
      fluidRow( box(
          leafletOutput("crime_danger"),
          height = 300,width = 12
   ))),
    tabItem(tabName = 'crimetop5',
            fluidRow(box(
              plotOutput('top5'), height=300,width = 12
            ))),
   tabItem(tabName = 'crimearea',
           fluidRow(box(
             plotOutput('crimearea'), height=300,width = 12
           ))),
   tabItem(tabName = 'washington_st',
           fluidRow(box(
             leafletOutput('washington_st'), height=300,width = 12
           ))),
   tabItem(tabName = 'washington_st_crime',
           fluidRow(box(
             plotOutput('washington_st_crime'), height=300,width = 12
           ))),
   tabItem(tabName = 'shooting_area',
           fluidRow( box(
             leafletOutput("shooting_area"),
             height = 300,width = 12
           ))),
   tabItem(tabName = 'shooting_month',
           fluidRow( box(
             plotOutput("shooting_month"),
             height = 300,width = 12
           ))),
   tabItem(tabName = 'shooting_week',
           fluidRow( box(
             plotOutput("shooting_week"),
             height = 300,width = 12
           ))),
   tabItem(tabName = 'shooting_day',
           fluidRow( box(
             plotOutput("shooting_day"),
             height = 300,width = 12
           )))

   
   
  ))
))
