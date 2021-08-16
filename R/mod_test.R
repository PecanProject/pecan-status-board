#' test UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,osutput,session Internal parameters for {shiny}.
#'
#' @noRd
#' 
#' @import magrittr
#'
#' @importFrom shiny NS tagList 


mod_test_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shinydashboard::box(width = 12, h2("Run Test, It's as simple as that!"),
                          actionButton(ns("runbutton"), "Run Test Now", icon = icon("play") ),
                          actionButton("viewlogs", "Check Logs", icon=icon("github-alt"), onclick ="window.open('https://github.com/theakhiljha/pecan-status-board/actions', '_blank')")),
      br(),
      shinydashboard::box(width = 12, title = "Result of last run", shinycssloaders::withSpinner(DT::DTOutput(ns("run_summary")))),
      br(),
      shinydashboard::box(width = 12, title = "Complete test summary", shinycssloaders::withSpinner(DT::DTOutput(ns("table"))))
    )
  )
}

#' test Server Functions
#'
#' @noRd 

mod_test_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    result <- testrun_report()
    observeEvent(input$runbutton,{
      run_test_dash()
      shinyWidgets::show_alert(
        title = "Test Initiated",
        text = "Click the check logs button to see the workflow",
        type = "success"
      )
    }, ignoreInit = TRUE)
    
    
    output$table <- DT::renderDT({
      DT::datatable(
        result,
        rownames = FALSE,
        filter = 'top',
        extensions = c("Buttons", "ColReorder", "Scroller"),
        options = list(
          scrollX = TRUE,
          scrollY = 500,
          scroller = TRUE,
          colReorder = TRUE,
          deferRender = TRUE,
          buttons = c('copy', 'csv', 'excel', 'pdf'),
          dom = "Bfrtip"
        ),
        style = "bootstrap")
    })
    
    output$run_summary <- DT::renderDT({
      
      last_run <- data.frame(result$workflow_id,result$site_name,result$site_id,result$model_name,result$model_id,result$met,result$success_status)
      last_run$result.workflow_id <- paste0("<a href='http://141.142.220.191/pecan/08-finished.php?workflowid=",last_run$result.workflow_id,"'>",last_run$result.workflow_id,"</a>")
      DT::datatable(
        last_run, escape = FALSE,
        filter = 'top',
        extensions = c("Buttons", "ColReorder", "Scroller"),
        options = list(
          scrollX = TRUE,
          scrollY = 500,
          scroller = TRUE,
          colReorder = TRUE,
          deferRender = TRUE,
          buttons = c('copy', 'csv', 'excel', 'pdf'),
          dom = "Bfrtip"
        ),
        style = "bootstrap") %>%
        DT::formatStyle(columns = "result.success_status", target = 'cell', backgroundColor = DT::styleEqual(c(TRUE,FALSE), c("#cdffae","#ffcccb"))
        )
    })
  })
}

## To be copied in the UI
# mod_test_ui("test_ui_1")

## To be copied in the server
# mod_test_server("test_ui_1")
