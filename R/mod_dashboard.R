#' dashboard UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 

mod_dashboard_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    fluidRow(
      shinydashboard::valueBox(
        "Next Test",
        subtitle = "At 06:05 UTC",
        icon = icon("github"),
        href="https://github.com/PecanProject/pecan-status-board/tree/main/.github/workflows/auto-schedule.yaml",
        color = "green"
      ),
      shinydashboard::valueBox(
        "Current Time",
        subtitle = Sys.time(),
        icon = icon("clock"),
        color = "maroon"
      ),
      shinydashboard::valueBox(
        "Code",
        subtitle = "GitHub",
        icon = icon("code"),
        href="https://github.com/PecanProject/pecan-status-board",
        color = "green"
      )
    ),
    fluidRow(
      shinydashboard::box(width = 4, tags$img(src = "https://github.com/PecanProject/pecan-status-board/actions/workflows/auto-schedule.yaml/badge.svg", height="100%", width="100%", align="center")),
      shinydashboard::box(width = 4, tags$img(src = "https://github.com/PecanProject/pecan-status-board/actions/workflows/push-ci.yaml/badge.svg", height="100%", width="100%", align="center")),
      shinydashboard::box(width = 4, tags$img(src = "https://github.com/PecanProject/pecan-status-board/actions/workflows/manual-test.yaml/badge.svg", height="100%", width="100%", align="center"))
    ),
    fluidRow(
      column(
        12,
        shinydashboard::box(width = "100%", title = "Scatter Plot",
                            shinycssloaders::withSpinner((plotly::plotlyOutput(ns("plot_scatter")))))
      )
    ),
    fluidRow(
      column(
        12,
        shinydashboard::box(width = 12,
                            shinycssloaders::withSpinner((plotOutput(ns("bar_plot1")))))
      )
    ),
    fluidRow(
      shinydashboard::box(
        shinycssloaders::withSpinner((plotOutput(ns("bar_plot2"))))),
      shinydashboard::box(
        shinycssloaders::withSpinner((plotOutput(ns("bar_plot3")))))
    )
  )
}

#' dashboard Server Functions
#' @noRd 

mod_dashboard_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    result <- testrun_report()
    
    output$plot_scatter <- plotly::renderPlotly({
      color_var <-
        ifelse(grepl("TRUE", result$success_status),"red", "green")
      plotly::plot_ly(
        data = result,
        x = ~ site_name,
        y = ~ model_name,
        text = ~ stage,
        color = ~ success_status,
        type = "scatter",
        size = 10,
        mode = "markers",
        colors = c("red", "green"),
        marker = list(
          sizemode = "diameter",
          opacity = 0.4,
          line = list(
            color = 'black',
            width = 1
          )
        ))
    })
    
    # Bar Plot of Sites and their Success Percentage
    
    output$bar_plot1 <- renderPlot({
      site_succ_percent <- tapply(result$success_status, result$site_name, mean) * 100
      s_df <- data.frame(site_succ_percent)
      all_sites <- tibble::rownames_to_column(s_df, var = "site_name")
      
      ggplot2::ggplot(data = all_sites,
                      ggplot2::aes(x = site_name,
                                   y = site_succ_percent,
                                   fill = site_succ_percent)) +
        ggplot2::ylim(0,100) +
        ggplot2::geom_bar(stat = "identity",
                          color = "black",
                          position = ggplot2::position_dodge()) +
        ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 4)) +
        ggplot2::theme_bw() +
        ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
        ggplot2::labs(title = "Success Percentage of Sites",
                      x = "Sites Name",
                      y = "Percentage(%)",
                      fill = " Success Percentage")
      
    }
    )
    
    # Bar Plot of Models and their Success Percentage
    
    output$bar_plot2 <- renderPlot({
      model_succ_percent <- tapply(result$success_status, result$model_name, mean) * 100
      s_df <- data.frame(model_succ_percent)
      all_models <- tibble::rownames_to_column(s_df, var = "model_name")
      
      ggplot2::ggplot(data = all_models,
                      ggplot2::aes(x = model_name,
                                   y = model_succ_percent,
                                   fill = model_succ_percent)) +
        ggplot2::ylim(0,100) +
        ggplot2::geom_bar(stat = "identity",
                          color = "black",
                          position = ggplot2::position_dodge()) +
        ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 4)) +
        ggplot2::theme_bw() +
        ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
        ggplot2::labs(title = "Success Percentage of Model",
                      x = "Models Name",
                      y = "Percentage(%)",
                      fill = " Success Percentage")
      
    }
    )
    
    # Bar Plot of Met and It's Success Percentage
    
    output$bar_plot3 <- renderPlot({
      met_succ_percent <- tapply(result$success_status, result$met, mean) * 100
      met_df <- data.frame(met_succ_percent)
      met_df <- na.omit(met_df)
      all_met <- tibble::rownames_to_column(met_df, var = "met_val")
      
      ggplot2::ggplot(data = all_met,
                      ggplot2::aes(x = met_val,
                                   y = met_succ_percent,
                                   fill = met_succ_percent)) +
        ggplot2::ylim(0,100) +
        ggplot2::geom_bar(stat = "identity",
                          color = "black",
                          position = ggplot2::position_dodge()) +
        ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 4)) +
        ggplot2::theme_bw() +
        ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
        ggplot2::labs(title = "Success Percentage of Met",
                      x = "Met",
                      y = "Percentage(%)",
                      fill = " Success Percentage")
      
    }
    )
    
  })}

## To be copied in the UI
# mod_dashboard_ui("dashboard_ui_1")

## To be copied in the server
# mod_dashboard_server("dashboard_ui_1")
