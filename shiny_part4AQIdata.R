library(shiny)
library(tidyverse)
library(ggplot2)
library(janitor)

read_csv("INDIA-AQI-DATA-2015-2020.csv") %>% 
  view() %>% 
  clean_names() -> aqi1

view(aqi1)



ui<- fluidPage(
  
  tableOutput("yr_tr")
  
  
)

server <- function(input , output,session )  {
  data1 <- reactive({
    "INDIA-AQI-DATA-2015-2020.csv" %>% 
      read_csv() %>% 
      clean_names() -> aqidf
  
    aqidf %>% 
      mutate(year = date %>% year(),
            month = date %>% month(),
            month2 = date %>% month(label = T),
            day = date %>% day(),
            week = date %>% week(),
            weekday = date %>% wday(label = T)) ->aqidf1
    
    aqidf1 %>% 
      pivot_longer(c(3:14), names_to = "pollutants", values_to = "values") -> aqidf2
    
    })
output$yr_tr <- renderTable({
  #yearwise pollutant trends 
  data1() %>% 
    group_by(year , pollutants) %>% 
    summarise(mean_value = mean(values , na.rm = T )) -> aqi_yearwise 
  
  
})
  
}
  
  
  
shinyApp(ui , server)
