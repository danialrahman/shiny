neuralPredict_UI<- function(){
  tabItem(tabName = "neuralPredict",
          
          fluidRow(
            
            
            valueBox("Prediction using neural", color="green", width=12, 
                     "Use neural net modal to predict outputs", 
                     icon = icon("brain", lib="font-awesome")),
            
            
            tabBox(width=12,
                   
                   title = tagList(icon("braille",lib="font-awesome"), "Input Types"),
                   
                   
                   tabPanel("Info", 
                            ################################################## Info  
                            
                            fluidRow(
                              
                              column(width=6,
                                     infoBox("Error Rate:", color="teal", width=12, 
                                              "2.499297", 
                                              icon = icon("bug", lib="font-awesome")),
                                     infoBox("Steps", color="fuchsia", width=12, 
                                              "15362", 
                                              icon = icon("shoe-prints", lib="font-awesome")),
                                     infoBox("Hidden Layer", color="aqua", width=12, 
                                             "5", 
                                             icon = icon("layer-group", lib="font-awesome")),
                                     infoBox("Inputs", color="navy", width=12, 
                                             "8", 
                                             icon = icon("sign-in-alt", lib="font-awesome")),
                                     infoBox("Outputs", color="olive", width=12, 
                                             "1", 
                                             icon = icon("sign-out-alt", lib="font-awesome"))
                                
                              ),
                              column(width=6,
                                  img(src = "neural.png", width ="100%")
                                    
                              )
                            )
                            
                            ################################################## 
                   ),
                   tabPanel("Materials",
                            ################################################## Materials          
                            
                            ## First Row
                            fluidRow(
                              column(width = 3,
                                     numericInput("cementInputN",label="Cement:",value=102)   
                              ),
                              column(width = 3,
                                     numericInput("slagInputN",label="Slag:",value=153)   
                              ),
                              column(width = 3,
                                     numericInput("ashInputN",label="Ash:",value=0)   
                              ),
                              column(width = 3,
                                     numericInput("waterInputN",label="Water:",value=192)   
                              )
                            ),
                            
                            ## Second Row
                            fluidRow(
                              column(width = 3,
                                     numericInput("spInputN",label="SuperPlastic:",value=0)   
                              ),
                              column(width = 3,
                                     numericInput("caggInputN",label="Course Agg:",value=887)   
                              ),
                              column(width = 3,
                                     numericInput("faggInputN",label="Fine Agg:",value=942)   
                              ),
                              column(width = 3,
                                     numericInput("ageInputN",label="Age:",value=90)   
                              )
                            ),
                            
                            ## Output Row
                            fluidRow(useShinyjs(),id="outputMaterialN",class="minimize", align="center",
                                     h4("Strength Output: "),
                                     uiOutput("strenghtPosN")
                            ),
                            
                            ## Submit Row
                            fluidRow(
                              column(width = 12, align="center",
                                     br(),
                                     actionButton("predictInputN",label="Predict!",
                                                  style="color: #fff; background-color: #337ab7; border-color: #2e6da4")  
                              ) 
                   )
            )
            
        )
            
            
      )   
  )#tabitem
}













neuralPredict_Server<- function(input, output, session){
  
  
  
  
  
  observeEvent(input$predictInputN, {
     #session$sendCustomMessage(type='alert',message=input$ageInputN)
    
    # concreteData_norm <- as.data.frame(lapply(concreteData,normalize))
    # concrete_test <- concreteData_norm
    # concrete_train <- concreteData_norm
    #   
    #   if (exists("concrete_model") == FALSE){
    #     concrete_model <- neuralnet(
    #       strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age,
    #       data=concrete_train,
    #       hidden=5
    #     )
    #   }
      
      concrete_model <- readRDS("data/model.rds")
      
      inputDatasN <- data.frame(input$cementInputN,input$slagInputN,
                                input$ashInputN,input$waterInputN,
                                input$spInputN,input$caggInputN,
                                input$faggInputN,input$ageInputN)
      colnames(inputDatasN) <- colnames(concreteData[1:8])
      
      inputDatasN_norm <- data.frame(
        normalizeSingle(inputDatasN$cement,concreteData$cement),
        normalizeSingle(inputDatasN$slag,concreteData$slag),
        normalizeSingle(inputDatasN$ash,concreteData$ash),
        normalizeSingle(inputDatasN$water,concreteData$water),
        normalizeSingle(inputDatasN$superplastic,concreteData$superplastic),
        normalizeSingle(inputDatasN$coarseagg,concreteData$coarseagg),
        normalizeSingle(inputDatasN$fineagg,concreteData$fineagg),
        normalizeSingle(inputDatasN$age,concreteData$age)
      )
      
      model_results <- compute(concrete_model, inputDatasN_norm)
      
      minvec <- min(concreteData$strength)
      maxvec <- max(concreteData$strength)
      resultOutput <- Map(denormalize,model_results$net.result,minvec,maxvec)
      
      removeClass("outputMaterialN", "minimize")
      
      output$strenghtPosN <- renderUI({
        h2(resultOutput)
      })
      
    })
  
}


normalizeSingle <- function(x,data){
  return((x-min(data))/(max(data)-min(data)))
}

normalize <- function(x){return((x-min(x))/(max(x)-min(x)))}

denormalize <- function(x,minval,maxval) {
  round(x*(maxval-minval) + minval, 2)
}