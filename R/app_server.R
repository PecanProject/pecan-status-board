#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  mod_dashboard_server("dashboard_ui_1")
  mod_test_server("test_ui_1")
  mod_weekly_report_server("weekly_report_ui_1")
  mod_workflows_satus_server("workflows_satus_ui_1")
}
