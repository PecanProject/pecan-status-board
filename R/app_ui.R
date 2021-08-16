#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' 
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
          shinydashboard::menuItem("Report", tabName = "report", icon = icon("chart-line"),
                                   shinydashboard::menuSubItem("Weekly Status", tabName = "weekly", icon = icon("calendar")),
                                   shinydashboard::menuSubItem("Workflows Status", tabName = "workflows", icon = icon("tasks")))
        )),
      
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          shinydashboard::tabItem("dashboard", mod_dashboard_ui("dashboard_ui_1")),
          shinydashboard::tabItem("test", mod_test_ui("test_ui_1")),
          shinydashboard::tabItem("weekly", mod_weekly_report_ui("weekly_report_ui_1")),
          shinydashboard::tabItem("workflows", mod_workflows_satus_ui("workflows_satus_ui_1")
          )
        ),
        # rightsidebar = NULL,
        # title = "Pecan Status Board"
      )
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
      app_title = 'PEcAn Status Board'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}