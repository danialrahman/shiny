csvPredict_UI<- function(){
  tabItem(tabName = "csvPredict",
          
          fluidRow(
            
            
            valueBox("Prediction using CSV file", color="green", width=12, 
                     "Compare and suggest the inputs from available datasets", 
                     icon = icon("file-excel", lib="font-awesome")),
            
            
            tabBox(width=12,
                   
                   title = tagList(icon("braille",lib="font-awesome"), "Input Types"),
                   tabPanel("Materials",
                            ################################################## Materials          
                            
                            ## First Row
                            fluidRow(
                              column(width = 3,
                                     numericInput("cementInput",label="Cement:",value=102)   
                              ),
                              column(width = 3,
                                     numericInput("slagInput",label="Slag:",value=153)   
                              ),
                              column(width = 3,
                                     numericInput("ashInput",label="Ash:",value=0)   
                              ),
                              column(width = 3,
                                     numericInput("waterInput",label="Water:",value=192)   
                              )
                            ),
                            
                            ## Second Row
                            fluidRow(
                              column(width = 3,
                                     numericInput("spInput",label="SuperPlastic:",value=0)   
                              ),
                              column(width = 3,
                                     numericInput("caggInput",label="Course Agg:",value=887)   
                              ),
                              column(width = 3,
                                     numericInput("faggInput",label="Fine Agg:",value=942)   
                              ),
                              column(width = 3,
                                     numericInput("ageInput",label="Age:",value=3)   
                              )
                            ),
                            
                            ## Output Row
                            fluidRow(useShinyjs(),id="outputMaterial",class="minimize", align="center",
                                     h4(textOutput("strenghtPos")),
                                     hr(),
                                     tableOutput("dataTableMaterial")
                            ),
                            
                            ## Submit Row
                            fluidRow(
                              column(width = 12, align="center",
                                     br(),
                                     actionButton("predictInput",label="Predict!",
                                                  style="color: #fff; background-color: #337ab7; border-color: #2e6da4")  
                              )
                            )
                            
                            ##################################################              
                   ),
                   
                   
                   
                   
                   tabPanel("Strength", 
                            ################################################## Strength  
                            
                            fluidRow(
                              column(width = 3,
                                     numericInput("expStrengthInput",label="Expected Strength: (15)",value="")   
                              ),
                              column(width = 3,
                                     numericInput("toleranceInput",label="Tolerance: (5)",value="")   
                              ),
                              column(width = 6,
                                     br(),
                                     actionButton("suggestInput",label="Suggest!", width="100%",
                                                  style="color: #fff; background-color: #337ab7; border-color: #2e6da4")  
                              )
                            ),
                            ## Output Row
                            fluidRow(useShinyjs(),id="outputStrength",class="minimize", align="center",
                                     h4("Lists of match material combination"),
                                     hr(),
                                     tableOutput("dataTableStrength")
                            )
                            
                            ################################################## 
                   )
            )
            
            
            
            
          )    
  )#tabitem
}



csvPredict_Server<- function(input, output, session){
  
  
  ################################################## Materials   
  filtering <- function(inputList){
    filterCement <- subset(prConcreteData, cement>=round((inputList[1] * lowRange),1) & cement<=round((inputList[1] * highRange),1))
    filterSlag <- subset(filterCement, slag>=round((inputList[2] * lowRange),1) & slag<=round((inputList[2] * highRange),1))
    filterAsh <- subset(filterSlag, ash>=round((inputList[3] * lowRange),1) & ash<=round((inputList[3] * highRange),1))
    filterWater <- subset(filterAsh, water>=round((inputList[4] * lowRange),1) & water<=round((inputList[4] * highRange),1))
    filterSp <- subset(filterWater, superplastic>=round((inputList[5] * lowRange),1) & superplastic<=round((inputList[5] * highRange),1))
    filterCagg <- subset(filterSp, coarseagg>=round((inputList[6] * lowRange),1) & coarseagg<=round((inputList[6] * highRange),1))
    filterFagg <- subset(filterCagg, fineagg>=round((inputList[7] * lowRange),1) & fineagg<=round((inputList[7] * highRange),1))
    filterAge <- subset(filterFagg, age>=round((inputList[8] * lowRange),1) & age<=round((inputList[8] * highRange),1))
    filterAge
    
  }
  
  
  
  
  highRange = 1 + (15/100) #+15% of original value
  lowRange = 1 - (15/100) #-15% of original value
  
  #cementInput <- reactive({ req(input$cementInput) })
  # slagInput   <- reactive({ req(input$slagInput) })
  #ashInput    <- reactive({ req(input$ashInput) })
  #waterInput  <- reactive({ req(input$waterInput) })
  # spInput     <- reactive({ req(input$spInput) })
  #caggInput   <- reactive({ req(input$caggInput) })
  #faggInput   <- reactive({ req(input$faggInput) })
  #ageInput   <- reactive({ req(input$ageInput) })
  
  
  
  observeEvent(input$predictInput, {
    # session$sendCustomMessage(type='alert',message=input$ageInput)
    
    inputList <- c(input$cementInput,input$slagInput,
                   input$ashInput,input$waterInput,
                   input$spInput,input$caggInput,
                   input$faggInput,input$ageInput)
    
    strengthData <- filtering(inputList)$strength
    strD <- ""
    for (i in strengthData){
      strD <- paste(strD,"(",i,")")
    }
    
    removeClass("outputMaterial", "minimize")
    
    output$strenghtPos <- renderText({
      paste("Strength possibilities: ",strD)
    })
    
    
    output$dataTableMaterial <- renderTable({
      filtering(inputList)
    })
    
    
    
  })
  
  
  
  
  # strengthData <- reactiveValues(strength = NULL)
  
  #observeEvent(input$ageInput, {
  #  strengthData$strength <- filtering()$strength
  #})
  
  #output$strenghtPos <- renderText({
  
  #  strD <- ""
  #  for (i in strengthData$strength){
  #   strD <- paste(strD,"(",i,")")
  # }
  # paste("Strength possibilities: ",strD)
  
  #})
  
  
  
  ################################################## Strength 
  
  observeEvent(input$suggestInput, {
    #session$sendCustomMessage(type='alert',message=(input$expStrengthInput+input$toleranceInput))
    
    removeClass("outputStrength", "minimize")
    
    output$dataTableStrength <- renderTable({
      sortStrength <- subset(prConcreteData, 
                             strength>=(input$expStrengthInput-input$toleranceInput) & 
                               strength<(input$expStrengthInput+input$toleranceInput+1))
    })
    
    
    
    
    
  })
  
  
  
}

