
table_UI<- function(){
  tabItem(tabName = "table",
          
          fluidRow(
            valueBox("Table Data", color ="aqua", width=12, "Simple table representation of datasets", icon = icon("table", lib = "font-awesome"))
          ),
          
          fluidRow(
            
            box( width=12, align="center",
                h3("Concrete Table Data"),
                DT::dataTableOutput("tableChart")
            )
          )
  )
}




table_Server<- function(input, output, session){
  
  tConcreteData <- concreteData
  output$tableChart = DT::renderDataTable({
    tConcreteData
  })
  
  
}