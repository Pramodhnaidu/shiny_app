library(shiny)
library(ggplot2)
library(tidyverse)


iris 


ui <- fluidPage(
  selectInput("sel", "choose species", choices = c("setosa", "versicolor", "virginica")),
  plotOutput("p1"),
  tableOutput("tb11")
  
  
)

server <- function(input, output , session) {
  data <- reactive({
    iris %>% 
    filter(Species == input$sel)
    })
  
  output$p1 <- renderPlot({
    data() %>% 
      ggplot(aes(Sepal.Width , Sepal.Length))+
      geom_point()
    
    
  })
  output$tb11 <- renderTable({
    iris %>% 
      filter(Species == input$sel)
  })
  
  
}


shinyApp(ui , server)
