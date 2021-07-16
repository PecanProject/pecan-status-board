#' workflows_satus UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_workflows_satus_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("Workflows Status")
  )
}

#' workflows_satus Server Functions
#'
#' @noRd 
mod_workflows_satus_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
  })
}

## To be copied in the UI
# mod_workflows_satus_ui("workflows_satus_ui_1")

## To be copied in the server
# mod_workflows_satus_server("workflows_satus_ui_1")
