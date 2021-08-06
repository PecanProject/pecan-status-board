#' weekly_report UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#' @import magrittr
#' @import reshape
#' @importFrom shiny NS tagList 
#' 
#' 
mod_weekly_report_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      shinydashboard::box(width = 12, title = "Weekly Run Percentage",shinycssloaders::withSpinner(plotOutput(ns("pie_chart"))))
    ),
    fluidPage(
      shinydashboard::box(width = 12, title = "Weekly Run Report", shinycssloaders::withSpinner(DT::DTOutput(ns("week_table"))))
    ))
}

#' weekly_report Server Functions
#'
#' @noRd 
mod_weekly_report_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    files = list.files(path="./data/", pattern="*.csv", full.names=TRUE)
    monday <- read.csv(files[2])
    tuesday <- read.csv(files[6])
    wednesday <- read.csv(files[7])
    thursday <- read.csv(files[5])
    friday <- read.csv(files[1])
    saturday <- read.csv(files[3])
    sunday <- read.csv(files[4])
    
    df <- data.frame(
      Monday = monday$success_status,
      Tuesday = tuesday$success_status,
      Wednesday = wednesday$success_status,
      Thursday = thursday$success_status,
      Friday = friday$success_status,
      Saturday = saturday$success_status,
      Sunday = sunday$success_status
    )
    
    # working pie chart
    
    
    output$pie_chart <- renderPlot({
      
      lvls <- unique(unlist(df))
      freq <- sapply(df, function(x) table(factor(x, levels = lvls, ordered = TRUE)))
      freq <- t(freq)
      final_data <- data.frame(freq)
      final_data <- tibble::rownames_to_column(final_data, "DAY")
      final_data <- reshape::melt(final_data, id='DAY')
      
      ggplot2::ggplot(data = final_data,
                      ggplot2::aes(
                        x = "",
                        y = value,
                        group = variable,
                        fill = variable
                      )) +
        ggplot2::geom_bar(width = 1, stat = "identity") +
        ggplot2::facet_grid(. ~ DAY) +
        ggplot2::facet_grid(~factor(DAY, levels=select_day())) +
        ggplot2::coord_polar(theta = "y", start = 0) +
        ggplot2::geom_text(ggplot2::aes(label = value),
                           position = ggplot2::position_stack(vjust = 0.5)) +
        ggplot2::labs(title = "", x = "", y = "Pie Chart", fill = "Success") +
        ggplot2::scale_fill_manual(values = c("green", "red")) +
        ggplot2::theme(axis.text = ggplot2::element_blank(),
                       axis.ticks = ggplot2::element_blank(),
                       panel.grid  = ggplot2::element_blank())
    } 
    )
    
    # Model time difference Weekly report
    
    output$week_table <- DT::renderDT({
      
      update_var <- testrun_report()
      sites_name = update_var$site_name
      models_name = update_var$model_name
      met = update_var$met
      model_diff <- weekly_time_diff()
      df <- data.frame(models_name,sites_name,met,model_diff)
      df <- df[ , select_tabledata()]
      
      DT::datatable(
        df,
        rownames = FALSE,
        filter = 'top',
        extensions = c("Buttons", "ColReorder", "Scroller"),
        options = list(
          scrollX = TRUE,
          scrollY = 500,
          scroller = TRUE,
          colReorder = TRUE,
          deferRender = FALSE,
          buttons = c('copy', 'csv', 'excel', 'pdf'),
          dom = "Bfrtip"
        ),
        style = "bootstrap") 
      # %>%
      #   DT::formatStyle(columns = c("Friday","Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday"), target = 'cell', backgroundColor = DT::styleEqual(c("","NA Sec"), c("#cdffae","#ffcccb"), default = "#cdffae")
      #   )
    })
  })
}

## To be copied in the UI
# mod_weekly_report_ui("weekly_report_ui_1")

## To be copied in the server
# mod_weekly_report_server("weekly_report_ui_1")
