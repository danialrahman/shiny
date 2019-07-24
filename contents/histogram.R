hstConcreteData <- concreteData

histogram_UI<- function(){
  tabItem(tabName = "histogram",
  
          
    fluidRow(
      valueBox("Histogram", color ="maroon", width=12, "Simple representation of Material's Interval vs Frequency", icon = icon("chart-bar", lib = "font-awesome"))
    ),
          
    fluidRow(   
      
      box(width=8,
        plotlyOutput("histoChart")
      ),
      
      box(width=4,
          
          radioButtons("materialType", "Choose a material:",
                       c("Cement" = "cement",
                         "Slag" = "slag",
                         "Ash" = "ash",
                         "Water" = "water",
                         "Super Plastic" = "superplastic",
                         "Coarse Aggregate" = "coarseagg",
                         "Fine Aggregate" = "fineagg"))
      )
    
    )
          
  )
}




histogram_Server<- function(input, output, session){
  
  
  observeEvent(input$materialType, {
    #session$sendCustomMessage(type='alert',message=(input$materialType))
    
    switch(input$materialType, 
      slag={ materialType <- hstConcreteData$slag },
      ash={ materialType <- hstConcreteData$ash },
      water={ materialType <- hstConcreteData$water },
      superplastic={ materialType <- hstConcreteData$superplastic },
      coarseagg={ materialType <- hstConcreteData$coarseagg },
      fineagg={ materialType <- hstConcreteData$fineagg },
      age={ materialType <- hstConcreteData$age },
      strength={ materialType <- hstConcreteData$strength },
      { materialType <- hstConcreteData$cement }
    )
    
    
    output$histoChart <- renderPlotly({
      p <- plot_ly(alpha=0.6, x = materialType, type = "histogram")%>%
        layout(xaxis = list(title = "Interval/Value"), yaxis = list(title = "Frequency"))
    })
    
  })
  
}