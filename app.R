library(shiny)
library(shinydashboard)
library(plotly)
packageVersion('plotly')
library(shinyjs)
library(neuralnet)
library(DT)

source("dashboard/header.R")
source("dashboard/sidebar.R")
source("contents/dashboard.R")
source("contents/table.R")
source("contents/piechart.R")
source("contents/histogram.R")
source("contents/scatter.R")
source("contents/predict.R")
source("contents/upload.R")


concreteData <- read.csv(file = "data/concrete.csv", header = TRUE)

ui <- dashboardPage(
  
  skin = "purple",
  dashboardHeader( 
    title = "Cattobot AI",      
    dashboardHeader_UI()   
  ),
  dashboardSidebar(
    dashboardSidebar_UI()
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
      tags$script(src = "custom.js")
    ),
    tabItems(
      dashboard_UI(),
      table_UI(),
      piechart_UI(),
      histogram_UI(),
      scatter_UI(),
      neuralPredict_UI(),
      csvPredict_UI(),
      upload_UI()
    )
  )
)

server <- function(input, output, session=NULL) {
  set.seed(122)
  dashboard_Server(input, output)
  table_Server(input, output, session)
  piechart_Server(input, output)  
  histogram_Server(input, output, session)
  scatter_Server(input, output, session)
  neuralPredict_Server(input, output, session)
  csvPredict_Server(input, output, session)
  upload_Server(input, output)
  
}

shinyApp(ui, server)