dashboardHeader_UI <-function(){
  dropdownMenu(type = "notifications",
    notificationItem(
      text = "Presentatiion for AI is today",
      icon = icon("exclamation-triangle"),
      status = "danger"
    ),
    notificationItem(
      text = "1030 data has been added",
      icon("file"),
      status = "warning"
    ),
    notificationItem(
      text = "7 functionality has been added!",
      icon = icon("thumbs-up"),
      status = "success"
    )
  ) 
}