dashboardSidebar_UI <-function(){
  
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Pie Charts", tabName = "pieChart", icon = icon("chart-pie", lib = "font-awesome")),
    menuItem("Histogram", tabName = "histogram", icon = icon("chart-bar", lib = "font-awesome")),
    menuItem("Scatter", tabName = "scatter", icon = icon("opencart", lib = "font-awesome")),
    menuItem("Prediction", icon = icon("code-branch", lib = "font-awesome"),
             menuSubItem("Net Neural Modal",icon = icon("brain", lib = "font-awesome"), tabName = "neuralPredict"),
             menuSubItem("CSV",icon = icon("file-excel", lib = "font-awesome"), tabName = "csvPredict")
    ),
    menuItem("Upload", tabName = "upload", icon = icon("upload", lib = "glyphicon"))
  )
  
  
}