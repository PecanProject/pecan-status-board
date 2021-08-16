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
  server <- rpecanapi::connect("http://141.142.220.191/", "ashiklom", "admin")
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
