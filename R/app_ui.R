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
          shinydashboard::menuItem("Dashboard", tabName = "dashboard", icon = shiny::icon("dashboard", lib = "font-awesome")),
          shinydashboard::menuItem("Test", tabName = "test", icon = icon("bolt",  lib="font-awesome")),
          shinydashboard::menuItem("Overall Report", tabName = "report", icon = shiny::icon("chart-line",  lib="font-awesome"),
                                   shinydashboard::menuSubItem("Weekly Status", tabName = "weekly", icon = shiny::icon("calendar",  lib="font-awesome")),
                                   shinydashboard::menuSubItem("Workflows Status", tabName = "workflows", icon = shiny::icon("tasks",  lib="font-awesome"))),
          shinydashboard::menuItem("Models", tabName = "models", icon = shiny::icon("chart-line", lib="font-awesome"),
                                   shinydashboard::menuSubItem("SIPNET", tabName = "sipnet", icon = shiny::icon("square", lib="font-awesome")),
                                   #shinydashboard::menuSubItem("BIOCRO", tabName = "biocro", icon = icon("square-b",  verify_fa = FALSE)),
                                   shinydashboard::menuSubItem("ED2.2", tabName = "ed2", icon = shiny::icon("square", lib="font-awesome")),
                                   #shinydashboard::menuSubItem("BASGRA", tabName = "basgra", icon = icon("circle-B",  verify_fa = FALSE)),
                                   shinydashboard::menuSubItem("MAESPA", tabName = "maespa", icon = shiny::icon("square", lib="font-awesome"))
                                                                     )
        )),
      
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          shinydashboard::tabItem("dashboard", mod_dashboard_ui("dashboard_ui_1")),
          shinydashboard::tabItem("test", mod_test_ui("test_ui_1")),
          shinydashboard::tabItem("weekly", mod_weekly_report_ui("weekly_report_ui_1")),
          shinydashboard::tabItem("workflows", mod_workflows_satus_ui("workflows_satus_ui_1")),
          shinydashboard::tabItem("models", mod_workflows_satus_ui("models_ui_1")),
          shinydashboard::tabItem("sipnet", mod_sipnet_ui("sipnet_1")),
          shinydashboard::tabItem("basgra", mod_basgra_ui("basgra_1")),
          shinydashboard::tabItem("maespa", mod_maespa_ui("maespa_1")),
          shinydashboard::tabItem("ed2", mod_ed2_ui("ed2_1")),
          shinydashboard::tabItem("biocro", mod_biocro_ui("biocro_1"))
          
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
      app_title = 'PEcAn Status Board'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}