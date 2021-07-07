#' test UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList


mod_test_ui <- function(id) {
  ns <- NS(id)
  tagList(fluidRow(
    shinydashboard::box(
      width = 12,
      h2("Run Test, It's as simple as that!"),
      actionButton(ns("runbutton"), "Run Test Now"),
      actionButton("viewlogs", "Check Logs", onclick =
                     "window.open('https://github.com/PecanProject/pecan-status-board/actions', '_blank')")
    ),
    br(),
    shinydashboard::box(width = 12, title = "Test Summary", DT::DTOutput(ns("table")))
  ))
}

#' test Server Functions
#'
#' @noRd

mod_test_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    observeEvent(input$runbutton, {
      run_test_dash()
    }, ignoreInit = TRUE)
    
    
    output$table <- DT::renderDT({
      result <- read.csv("inst/test_results.csv")
      DT::datatable(
        result,
        rownames = FALSE,
        filter = 'top',
        extensions = c("Buttons", "ColReorder", "Scroller"),
        options = list(
          rownames = FALSE,
          scrollX = TRUE,
          scrollY = 500,
          scroller = TRUE,
          colReorder = TRUE,
          deferRender = TRUE,
          buttons = c('copy', 'csv', 'excel', 'pdf'),
          dom = "Bfrtip"
        ),
        style = "bootstrap"
      )
    })
  })
}

## To be copied in the UI
# mod_test_ui("test_ui_1")

## To be copied in the server
# mod_test_server("test_ui_1")
