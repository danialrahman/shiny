upload_UI<- function(){
  
  tabItem(tabName = "upload",
          
    fluidRow(
      
      valueBox(nrow(concreteData), width=12, "Data Sets", icon = icon("equalizer", lib="glyphicon")),
      
      box( width=12,
           
           h4("Upload new data to existing datasets"),
           
           hr(),
           
           fileInput("csvdata", "Choose CSV File",
                     accept = c(
                       "text/csv",
                       "text/comma-separated-values,text/plain",
                       ".csv")
           ),
           br(),
           tableOutput("tableReview")
          # uiOutput("contents")    
      )
            
    )
  )
}



upload_Server<- function(input, output){
  
  fileUpload <- reactiveValues(df_data = NULL)
  observeEvent(input$csvdata, {
    fileUpload$df_data <- read.csv(input$csvdata$datapath)
    
    file.rename("data/concrete.csv","data/concrete-old.csv")
    newData = rbind(concreteData,fileUpload$df_data)
    write.csv(newData, file="data/concrete.csv", row.names = FALSE)
  }) 
  
  output$tableReview <- renderTable({
    fileUpload$df_data
  })
  
  
  #output$contents <- renderUI({
  #  selectInput('data_option',
  #              choices = names(fileUpload$df_data),
  #              label = "Select the Variable")
  #})
  
  
}

