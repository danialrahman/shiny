piechart_UI<- function(){
  # Second tab content
  tabItem(tabName = "pieChart",
          
          fluidRow(
            
            box( width=8, align="center",
                 h4(textOutput('pieChartTitle')),
                 hr(),
                 plotlyOutput('pieChart')
            ),
            
            valueBox("Pie Chart", color ="orange", width=4, "Simple representation in weightage of concrete", icon = icon("chart-pie", lib = "font-awesome")),
            
            box( width=4,
                 h4("Number of Datasets"),
                 hr(),
                 sliderInput(inputId = "datasetSlider",
                             label = "Adjust slider to change no. of datasets",
                             min = 1,
                             max = nrow(concreteData),
                             value = nrow(concreteData))
            )
            
            
          )
  )
}



piechart_Server<- function(input, output){
  
  
  pcConcreteData <- concreteData
  pcConcreteData$age <- NULL
  pcConcreteData$strength <- NULL
  
  
  output$pieChartTitle <- renderText({ 
    paste("Concrete ingredients weightage of ", input$datasetSlider ," Datasets")
  })
  
  
  dataset <- reactive({
    
    limit = input$datasetSlider 
    
    sumConcreteData = c(sum(pcConcreteData$cement[1:limit]),sum(pcConcreteData$slag[1:limit]),
                        sum(pcConcreteData$ash[1:limit]),sum(pcConcreteData$water[1:limit]),
                        sum(pcConcreteData$superplastic[1:limit]),sum(pcConcreteData$coarseagg[1:limit]),
                        sum(pcConcreteData$fineagg[1:limit]))
  })
             
  output$pieChart <- renderPlotly({
    p <- plot_ly(concreteData, labels = colnames(pcConcreteData), values = dataset(), type = 'pie') %>%
      layout(title = '',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
  })
  
  
}
    
    