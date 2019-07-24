dashboard_UI<- function(){
  # First tab content
  
  tabItem(tabName = "dashboard",
          
          
          fluidRow(
            
            valueBox(7, "Total Functionality", icon = icon("project-diagram", lib="font-awesome")),
            
            valueBox(nrow(concreteData), "Datasets", color = "purple", icon = icon("equalizer", lib="glyphicon")),
            
            valueBox(10, "Team Members", color = "orange", icon("users", lib = "font-awesome"))
            
          ),
          fluidRow(
            
            box(width = 6,
                img(src = "ai.jpg", width ="100%"),
                br(),
                br(),
                p("This project is about the concrete dataset being represented in pie chart, 
                  histogram and plot graph. The dataset will be pick using the checkbox and slider input.")
                
            ),
            
            box(width = 6,
              h3("Team Members"),
              hr(),
              p("Danial bin Abd Rahman"),
              p("Adiy Zofrul Mohd Hanizan"),
              p("Ahmad Rashdan bin Zulkifli"),
              p("Muhammad Taqiuddin bin Talib"),
              p("Muhammad Amir Aqil bin Mohamad Dzol"),
              p("Nur Ain binti M Salleh Amran"),
              p("Siti Nurfathehah binti Zulkifly"),
              p("Haiza Shazleen bt Hawazil"),
              p("Nurin Nabilah binti Nazlan"),
              p("Zulaikha binti Zulhairi")
            )
          )
  )
}




dashboard_Server<- function(input, output){
 
}