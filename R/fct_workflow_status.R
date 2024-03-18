#' workflow_status 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#' @import httr
#' @import rpecanapi
#' @import tibble
#'
#' @noRd


workflow_status <- function(report){
  server <- rpecanapi::connect("http://pecan.localhost/", "carya", "illinois")
  id <- report$workflow_id
  result <- data.frame()
  for (i in id) {
    data <- rpecanapi::get.workflow.status(server, workflow_id = i )
    df <- tibble::tibble(
      Workflow_id = data$workflow_id,
      TRAIT = data$status[1],
      META = data$status[2],
      CONFIG = data$status[3],
      MODEL = data$status[4],
      OUTPUT = data$status[5],
      ENSEMBLE = data$status[6],
      FINISHED = data$status[7],
    )
    n_rows <- nrow(df)
    
    temp <- df[seq.int(from = n_rows, by = -1L, length.out = n_rows), ]
    result <- rbind(result, temp)
  }
  return(result)
}

wf_sites_status <- function(data) {
  data <- (reshape::melt(data, id.vars = "Workflow_id"))
  data <- as.data.frame(data)
  data$status <- ifelse(grepl("DONE", data$value),"DONE","ERROR")
  data <- tidyr::separate(data = data, col = value, into = c("Val","Start_Time","End_Time","status11"), sep = "  ")
  data <- subset(data, select = -c(Val, status11))
  data$Start_Time <- strptime(data$Start_Time, format = "%Y-%m-%d %H:%M:%OS")
  data$End_Time <- strptime(data$End_Time, format = "%Y-%m-%d %H:%M:%OS")
  data$diff <- with(data, difftime(End_Time,Start_Time,units="secs"))
  data$final_status <- paste(data$diff, data$status)
  return(data)
}

