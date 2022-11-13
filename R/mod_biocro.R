#' biocro UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' 

mod_biocro_ui <- function(id){
  ns <- NS(id)
  # count <- biocro_report()
  # biocro_count <- workflow_count(count)
  # pass_test <- success_count(count)
  # fail_test <- failure_count(count)
  # 
  tagList(
    #   fluidRow(
    # 
    #     tagList(
    #       fluidRow(
    #         shinydashboard::valueBox(
    #           "Next Run",
    #           subtitle = '06:30 AM UST',
    #           icon = icon("bell"),
    #           color = "teal"
    #         ),
    #         shinydashboard::valueBox(
    #           'Time',
    #           subtitle = Sys.time(),
    #           icon = icon("clock"),
    #           color = "olive"
    #         ),
    #         shinydashboard::valueBox(
    #           "Check Logs",
    #           subtitle = 'Details',
    #           icon = icon("chart-simple"),
    #           color = "maroon"
    #         ),
    #         shinydashboard::valueBox(
    #           "Workflows",
    #           subtitle = biocro_count,
    #           icon = icon("gears"),
    #           color = "purple"
    #         ),
    #         shinydashboard::valueBox(
    #           "Passed",
    #           subtitle = pass_test,
    #           icon = icon("check"),
    #           color = "green"
    #         ),
    #         shinydashboard::valueBox(
    #           "Failed",
    #           subtitle = fail_test,
    #           icon = icon("xmark"),
    #           color = "red"
    #         )
    #       )
    #     ),
    #     fluidRow(
    #       shinydashboard::box(width = 6, title = "Met Status",
    #                           shinycssloaders::withSpinner((plotOutput(ns("bar_plot1"))))),
    #       shinydashboard::box(width =6 ,title = "Sites Status", shinycssloaders::withSpinner(DT::DTOutput(ns("status_table"))))
    #     ),
    #     fluidRow(
    #       shinydashboard::tabBox( width = 12, title = "Status of Sites Workflows",
    #                               tabPanel(title = "AmerifluxLBL", width = 12, shinycssloaders::withSpinner(plotOutput(ns("heatmap1")))
    #                               ),
    #                               tabPanel(title = "CRUNCEP", width = 12, shinycssloaders::withSpinner(plotOutput(ns("heatmap2")))
    #                               ),
    #                               tabPanel(title = "FLUXNET2015", width = 12, shinycssloaders::withSpinner(plotOutput(ns("heatmap3")))
    #                               ),
    #                               tabPanel(title = "NARR", width = 12, shinycssloaders::withSpinner(plotOutput(ns("heatmap4")))
    #                               ),
    #                               tabPanel(title = "GFDL", width = 12, shinycssloaders::withSpinner(plotOutput(ns("heatmap5")))
    #                               )
    #       )),
    #     fluidRow(
    #       shinydashboard::tabBox( width = 12,
    #                               tabPanel(title = "Workflows Log",
    #                                        width = 12, shinycssloaders::withSpinner(DT::DTOutput(ns("error_table")))))
    # 
    #     ))
    # 
  )
}

#' biocro Server Functions
#'
#' @noRd 
mod_biocro_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    #   result <- biocro_report()
    #   output$bar_plot1 <- renderPlot({
    #     met_succ_percent <- tapply(result$success_status, result$met, mean) * 100
    #     met_df <- data.frame(met_succ_percent)
    #     met_df <- na.omit(met_df)
    #     all_met <- tibble::rownames_to_column(met_df, var = "met_val")
    #     
    #     # Success percentage of Mets
    #     
    #     ggplot2::ggplot(data = all_met,
    #                     ggplot2::aes(x = met_val,
    #                                  y = met_succ_percent,
    #                                  fill = met_succ_percent)) +
    #       ggplot2::ylim(0,100) +
    #       ggplot2::geom_bar(stat = "identity",
    #                         color = "black",
    #                         position = ggplot2::position_dodge()) +
    #       #ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 4)) +
    #       ggplot2::theme_bw() +
    #       ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    #       ggplot2::labs(title = "Success Percentage of Met",
    #                     x = "Met",
    #                     y = "Percentage(%)",
    #                     fill = " Success Percentage")
    #     
    #   }
    #   )
    #   
    #   # Table 
    #   
    #   output$status_table <- DT::renderDT({
    #     test_result = data.frame(result$site_id,result$site_name,result$pfts,result$success_status)
    #     DT::datatable(
    #       data = test_result,
    #       rownames = TRUE,
    #       colnames=c("Site ID", "Site Name", "PFTs", "Status"),
    #       extensions = c("Buttons", "ColReorder", "Scroller"),
    #       options = list(
    #         autoWidth = TRUE,
    #         scrollX = TRUE,
    #         scrollY = 250,
    #         scroller = TRUE,
    #         colReorder = TRUE,
    #         deferRender = TRUE,
    #         buttons = c('copy', 'csv', 'excel', 'pdf'),
    #         dom = "Bfrtip",
    #         columnDefs = list(
    #           list(orderable = TRUE, className = 'details-control', targets = 1)
    #         )
    #       )
    #     )
    #   })
    #   
    #   # Getting Status of Workflows for Sites
    #   report <- biocro_report()
    #   report1 <- data.frame(report$site_id,report$pft,report$site_name,report$workflow_id) 
    #   colnames(report1) <- c('site_id','pfts','site_name','Workflow_id')
    #   data <- as.data.frame(workflow_status(report))
    #   data <- (reshape::melt(data, id.vars = "Workflow_id"))
    #   data <- as.data.frame(data)
    #   data$status <- ifelse(grepl("DONE", data$value),"DONE","ERROR")
    #   data <- tidyr::separate(data = data, col = value, into = c("Val","Start_Time","End_Time","status11"), sep = "  ")
    #   data <- subset(data, select = -c(Val, status11))
    #   data$Start_Time <- strptime(data$Start_Time, format = "%Y-%m-%d %H:%M:%OS")
    #   data$End_Time <- strptime(data$End_Time, format = "%Y-%m-%d %H:%M:%OS")
    #   data$diff <- with(data, difftime(End_Time,Start_Time,units="secs")) %>%
    #     paste("")
    #   data$final_status <- paste(data$diff, data$status)
    #   main_data <- merge(report1,data, by = 'Workflow_id')
    #   
    #   # Error Log
    #   
    #   output$error_table <- DT::renderDT({
    #     error_data = read.csv("data/biocro-test/logs/biocro-log-data.csv")
    #     error_data = data.frame(error_data$final_df.workflow_id,error_data$final_df.site_id,error_data$final_df.site_name,error_data$final_df.success_status,
    #                             error_data$final_df.error_log,error_data$final_df.met)
    #     DT::datatable(
    #       data = error_data,
    #       rownames = TRUE,
    #       colnames=c("workflow_id","site_id","site_name","success_status","error_log","met"),
    #       extensions = c("Buttons", "ColReorder", "Scroller"),
    #       options = list(
    #         autoWidth = TRUE,
    #         scrollX = TRUE,
    #         scrollY = 250,
    #         scroller = TRUE,
    #         colReorder = TRUE,
    #         deferRender = TRUE,
    #         buttons = c('copy', 'csv', 'excel', 'pdf'),
    #         dom = "Bfrtip",
    #         columnDefs = list(
    #           list(orderable = TRUE, className = 'details-control', targets = 1)
    #         )
    #       )
    #     )
    #   })
    #   
    #   # Getting Status of Workflows for Sites
    #   
    #   #Ameriflux
    #   output$heatmap1 <- renderPlot({
    #     report_all <- biocro_report()
    #     report_AM <- report_all[report_all$met == 'AmerifluxLBL', ]
    #     report1 <- data.frame(report_AM$site_id,report_AM$pft,report_AM$site_name,report_AM$workflow_id,report_AM$met) 
    #     colnames(report1) <- c('site_id','pfts','site_name','Workflow_id',"met")
    #     data <- as.data.frame(workflow_status(report_AM))
    #     data <- wf_sites_status(data)
    #     main_data_AM <- merge(report1,data, by = 'Workflow_id')
    #     col1 <- c("DONE","ERROR")
    #     col2 <- c("green", "red")
    #     f_col <- data.frame(col1,col2)
    #     col.plot <- as.character(f_col$col2)
    #     names(col.plot) <- as.character(f_col$col1)
    #     ggplot2::ggplot(data = main_data_AM, ggplot2::aes(x = as.character(site_id), 
    #                                                       y = variable, fill= status)) +
    #       ggplot2::scale_fill_manual(values = col.plot)  +
    #       ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 3)) +
    #       ggplot2::geom_tile(color = "white",
    #                          lwd = 1.5,
    #                          linetype = 1) +
    #       ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    #       ggplot2::coord_fixed() +
    #       ggplot2::theme_minimal()+
    #       ggplot2::labs(title = "Heat map",
    #                     x = "site_id",
    #                     y = "stages",
    #                     fill = "status"
    #       )
    #   })
    #   
    #   #CRUNCEP
    #   
    #   output$heatmap2 <- renderPlot({
    #     report_all <- biocro_report()
    #     report_CR <- report_all[report_all$met == 'CRUNCEP', ]
    #     report2 <- data.frame(report_CR$site_id,report_CR$pft,report_CR$site_name,report_CR$workflow_id,report_CR$met) 
    #     colnames(report2) <- c('site_id','pfts','site_name','Workflow_id',"met")
    #     data <- as.data.frame(workflow_status(report_CR))
    #     data <- wf_sites_status(data)
    #     main_data_CR <- merge(report2,data, by = 'Workflow_id')
    #     col1 <- c("DONE","ERROR")
    #     col2 <- c("green", "red")
    #     f_col <- data.frame(col1,col2)
    #     col.plot <- as.character(f_col$col2)
    #     names(col.plot) <- as.character(f_col$col1)
    #     ggplot2::ggplot(data = main_data_CR, ggplot2::aes(x = as.character(site_id), 
    #                                                       y = variable, fill= status)) +
    #       ggplot2::scale_fill_manual(values = col.plot)  +
    #       ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 3)) +
    #       ggplot2::geom_tile(color = "white",
    #                          lwd = 1.5,
    #                          linetype = 1) +
    #       ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    #       ggplot2::coord_fixed() +
    #       ggplot2::theme_minimal()+
    #       ggplot2::labs(title = "Heat map",
    #                     x = "site_id",
    #                     y = "stages",
    #                     fill = "status"
    #       )
    #   })
    #   
    #   #Fluxnet
    #   
    #   output$heatmap3 <- renderPlot({
    #     report_all <- biocro_report()
    #     report_FN <- report_all[report_all$met == 'Fluxnet2015', ]
    #     report3 <- data.frame(report_FN$site_id,report_FN$pft,report_FN$site_name,report_FN$workflow_id,report_FN$met) 
    #     colnames(report3) <- c('site_id','pfts','site_name','Workflow_id',"met")
    #     data <- as.data.frame(workflow_status(report_FN))
    #     data <- wf_sites_status(data)
    #     main_data_FN <- merge(report3,data, by = 'Workflow_id')
    #     col1 <- c("DONE","ERROR")
    #     col2 <- c("green", "red")
    #     f_col <- data.frame(col1,col2)
    #     col.plot <- as.character(f_col$col2)
    #     names(col.plot) <- as.character(f_col$col1)
    #     ggplot2::ggplot(data = main_data_FN, ggplot2::aes(x = as.character(site_id), 
    #                                                       y = variable, fill= status)) +
    #       ggplot2::scale_fill_manual(values = col.plot)  +
    #       ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 3)) +
    #       ggplot2::geom_tile(color = "white",
    #                          lwd = 1.5,
    #                          linetype = 1) +
    #       ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    #       ggplot2::coord_fixed() +
    #       ggplot2::theme_minimal()+
    #       ggplot2::labs(title = "Heat map",
    #                     x = "site_id",
    #                     y = "stages",
    #                     fill = "status"
    #       )
    #   })
    #   
    #   #NARR
    #   
    #   output$heatmap4 <- renderPlot({
    #     report_all <- biocro_report()
    #     report_NR <- report_all[report_all$met == 'NARR', ]
    #     report4 <- data.frame(report_NR$site_id,report_NR$pft,report_NR$site_name,report_NR$workflow_id,report_NR$met) 
    #     colnames(report4) <- c('site_id','pfts','site_name','Workflow_id',"met")
    #     data <- as.data.frame(workflow_status(report_NR))
    #     data <- wf_sites_status(data)
    #     main_data_NR <- merge(report4,data, by = 'Workflow_id')
    #     col1 <- c("DONE","ERROR")
    #     col2 <- c("green", "red")
    #     f_col <- data.frame(col1,col2)
    #     col.plot <- as.character(f_col$col2)
    #     names(col.plot) <- as.character(f_col$col1)
    #     ggplot2::ggplot(data = main_data_NR, ggplot2::aes(x = as.character(site_id), 
    #                                                       y = variable, fill= status)) +
    #       ggplot2::scale_fill_manual(values = col.plot)  +
    #       ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 3)) +
    #       ggplot2::geom_tile(color = "white",
    #                          lwd = 1.5,
    #                          linetype = 1) +
    #       ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    #       ggplot2::coord_fixed() +
    #       ggplot2::theme_minimal()+
    #       ggplot2::labs(title = "Heat map",
    #                     x = "site_id",
    #                     y = "stages",
    #                     fill = "status"
    #       )
    #   })
    #   
    #   #GFDL
    #   
    #   output$heatmap5 <- renderPlot({
    #     report_all <- biocro_report()
    #     report_GF <- report_all[report_all$met == 'GFDL', ]
    #     report5 <- data.frame(report_GF$site_id,report_GF$pft,report_GF$site_name,report_GF$workflow_id,report_GF$met) 
    #     colnames(report5) <- c('site_id','pfts','site_name','Workflow_id',"met")
    #     data <- as.data.frame(workflow_status(report_GF))
    #     data <- wf_sites_status(data)
    #     main_data_NR <- merge(report5,data, by = 'Workflow_id')
    #     col1 <- c("DONE","ERROR")
    #     col2 <- c("green", "red")
    #     f_col <- data.frame(col1,col2)
    #     col.plot <- as.character(f_col$col2)
    #     names(col.plot) <- as.character(f_col$col1)
    #     ggplot2::ggplot(data = main_data_NR, ggplot2::aes(x = as.character(site_id), 
    #                                                       y = variable, fill= status)) +
    #       ggplot2::scale_fill_manual(values = col.plot)  +
    #       ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 3)) +
    #       ggplot2::geom_tile(color = "white",
    #                          lwd = 1.5,
    #                          linetype = 1) +
    #       ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    #       ggplot2::coord_fixed() +
    #       ggplot2::theme_minimal()+
    #       ggplot2::labs(title = "Heat map",
    #                     x = "site_id",
    #                     y = "stages",
    #                     fill = "status"
    #       )
    #   })
    #   
    #   ###ENDS
    #   
    # 
  })
}

## To be copied in the UI
# mod_biocro_ui("biocro_1")

## To be copied in the server
# mod_biocro_server("biocro_1")
