sctConcreteData <- concreteData

scatter_UI<- function(){
  tabItem(tabName = "scatter",
          
          fluidRow(
            valueBox("Scatter Plots", color ="teal", width=12, "Simple scatter plot representation of frequencies in material's density", icon = icon("chart-pie", lib = "font-awesome"))
          ),
          
          fluidRow(
            
            box( width=12, align="center",
                 plotlyOutput('scatterChart')
            )
            
            
          )
  )
}



scatter_Server<- function(input, output, session){
  
  observeEvent(input$materialType, {
    #session$sendCustomMessage(type='alert',message=(input$materialType))
    
    
    parameters <- c("Value","Age","Strength","Material")
    
    cementData <- cbind(subset(sctConcreteData, select = c(cement,age,strength)),c("cement"))
      colnames(cementData) <- parameters
      
    slagData <- cbind(subset(sctConcreteData, select = c(slag,age,strength)),c("slag"))
      colnames(slagData) <- parameters
    
    ashData <- cbind(subset(sctConcreteData, select = c(ash,age,strength)),c("ash"))
      colnames(ashData) <- parameters
    
    waterData <- cbind(subset(sctConcreteData, select = c(water,age,strength)),c("water"))
      colnames(waterData) <- parameters
    
    superplasticData <- cbind(subset(sctConcreteData, select = c(superplastic,age,strength)),c("superplastic"))
      colnames(superplasticData) <- parameters
      
    coarseaggData <- cbind(subset(sctConcreteData, select = c(coarseagg,age,strength)),c("coarseagg"))
      colnames(coarseaggData) <- parameters
    
    fineaggData <- cbind(subset(sctConcreteData, select = c(fineagg,age,strength)),c("fineagg"))
      colnames(fineaggData) <- parameters
    
    sctConcreteDataFilter <- rbind(cementData,slagData,ashData,waterData,superplasticData,coarseaggData,fineaggData)
    
    output$scatterChart <- renderPlotly({
      p <- plot_ly(data = sctConcreteDataFilter, x = ~Value, y = ~Strength, color = ~Material)
    })
    
  })
  
  
}


normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}


