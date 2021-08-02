#' workflows_satus UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 

#' @importFrom shiny NS tagList 
#' @import magrittr
#' 
#' 
mod_workflows_satus_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shinydashboard::tabBox( width = 12,
                              tabPanel(title = "Heatmap of Workflows Status", width = 12, plotOutput(ns("heatmap"))
                              ),
                              tabPanel(title = "Bar Plot of Workflows Status ", width = 12, plotOutput(ns("bar"))
                              )
      )
    ),
    fluidPage(
      shinydashboard::box(width = 12, title = "Workflow Status", DT::DTOutput(ns("workflow_table")))
    )
  )
}

#' workflows_satus Server Functions
#'
#' @noRd 
#' 
#' 
mod_workflows_satus_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    test_result <- workflow_status()
    
    # Get workflows status using API
    
    data <- as.data.frame(workflow_status())
    data <- (melt(data, id.vars = "Workflow_id"))
    data <- as.data.frame(data)
    data$status <- ifelse(grepl("DONE", data$value),"DONE","ERROR")
    
    data <- tidyr::separate(data = data, col = value, into = c("Val","Start_Time","End_Time","status11"), sep = "  ")
    data <- subset(data, select = -c(Val, status11))
    data$Start_Time <- strptime(data$Start_Time, format = "%Y-%m-%d %H:%M:%OS")
    data$End_Time <- strptime(data$End_Time, format = "%Y-%m-%d %H:%M:%OS")
    data$diff <- with(data, difftime(End_Time,Start_Time,units="secs")) %>%
      paste("Sec")
    data$final_status <- paste(data$diff, data$status)
    
    # Heat map of Workflows Status using ggplot2
    
    output$heatmap <- renderPlot({
      col.plot<-c("#cdffae","#ffcccb")
      ggplot2::ggplot(data = data, ggplot2::aes(x = Workflow_id, y = variable, fill =
                                                  status)) +
        ggplot2::scale_fill_manual(values = col.plot)  +
        ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 3)) +
        ggplot2::geom_tile(color = "white",
                           lwd = 1.5,
                           linetype = 1) +
        ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
        ggplot2::geom_text(ggplot2::aes(label = diff), color = "black", size = 4) +
        ggplot2::coord_fixed() +
        ggplot2::labs(title = "Heat map",
                      x = "workflow_id",
                      y = "value",
                      fill = "final status")
    })
    
    # Bar Plot of Workflows Status using ggplot2   
    
    output$bar <- renderPlot({
      ggplot2::ggplot(data = data, ggplot2::aes(x = Workflow_id, y = variable, fill = status)) +
        ggplot2::geom_bar(stat = "identity", position = ggplot2::position_dodge()) +
        ggplot2::theme_minimal() +
        ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 4)) +
        ggplot2::scale_fill_manual(values = c("#cdffae","#ffcccb")) +
        ggplot2::labs(title = "Bar Plot",
                      x = "workflow_id",
                      y = "value",
                      fill = "final status")
    }) 
    
    # Summary of final status of workflows.
    
    output$workflow_table <- DT::renderDT({
      test_result <- cast(data = data, formula = Workflow_id~variable, value.var = "final_status")
      DT::datatable(
        test_result,
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
  })
}

## To be copied in the UI
# mod_workflows_satus_ui("workflows_satus_ui_1")

## To be copied in the server
# mod_workflows_satus_server("workflows_satus_ui_1")
