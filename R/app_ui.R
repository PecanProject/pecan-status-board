#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic '
    shinydashboard::dashboardPage(
      skin = "green",
      header = shinydashboard::dashboardHeader(
        title = "Pecan Status Board",
        
        shinydashboard::dropdownMenu(type = "messages", icon = icon("clock"),
                                     shinydashboard::messageItem(
                                       from = "Test Alert",
                                       message = "Next scheduled test will start at 06:05 UTC",
                                       icon = icon("clock"),
                                       time = Sys.time()
                                     ))
      ),
      
      shinydashboard::dashboardSidebar(
        shinydashboard::sidebarMenu(
          shinydashboard::menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
          shinydashboard::menuItem("Test", tabName = "test", icon = icon("bolt")),
          shinydashboard::menuItem("Report", tabName = "report", icon = icon("chart-line"))
        )),
      
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          shinydashboard::tabItem("dashboard", mod_dashboard_ui("dashboard_ui_1")),
          shinydashboard::tabItem("test", mod_test_ui("test_ui_1")),
          shinydashboard::tabItem("report", mod_report_ui("report_ui_1"))
        )
      ),
      # rightsidebar = NULL,
      # title = "Pecan Status Board"
    )
    
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'statusboard'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}