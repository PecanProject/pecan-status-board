#' time_diff 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#' @import magrittr
#' 
#' @noRd

time_diff <- function(df) {
  df <- testrun_report()
  df <- tidyr::separate(data = df, col = stage, into = c("stage_status","start_time", "end_time","final_status" ), sep = "  ")
  df <- g <- subset(df, select = -c(stage_status, final_status))
  df$start_time <- strptime(df$start_time, format = "%Y-%m-%d %H:%M:%OS")
  df$end_time <- strptime(df$end_time, format = "%Y-%m-%d %H:%M:%OS")
  df$diff <- with(df, difftime(end_time,start_time, units="secs")) %>%
    paste("Sec")
  df$diff <- df$final_status <- paste(df$diff, df$success_status)
}
