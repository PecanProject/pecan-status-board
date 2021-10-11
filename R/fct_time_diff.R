#' time_diff 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#' @import magrittr
#' @import tidyr
#' @noRd

#Calculates time difference

time_diff <- function(df) {
  df <- testrun_report()
  df <- tidyr::separate(data = df, col = stage, into = c("Val","start_time", "end_time","final_status" ), sep = "  ")
  df <- subset(df, select = -c(Val, final_status))
  df$start_time <- strptime(df$start_time, format = "%Y-%m-%d %H:%M:%OS")
  df$end_time <- strptime(df$end_time, format = "%Y-%m-%d %H:%M:%OS")
  df$diff <- with(df, difftime(end_time,start_time, units="secs")) %>%
    paste("Sec")
  df$diff <- df$final_status <- paste(df$diff, df$success_status)
}

# Calcuates time difference of the models

model_time_diff <- function(df) {
  df <- as.data.frame(workflow_status(df))
  df <- subset(df, select = -c(TRAIT,META,CONFIG,OUTPUT,ENSEMBLE,FINISHED))
  df <- tidyr::separate(data = df, col = MODEL, into = c("status","start_time", "end_time","final_status" ), sep = "  ")
  df <- subset(df, select = -c(status, final_status))
  df$start_time <- strptime(df$start_time, format = "%Y-%m-%d %H:%M:%OS")
  df$end_time <- strptime(df$end_time, format = "%Y-%m-%d %H:%M:%OS")
  with(df, difftime(end_time,start_time, units="secs")) %>%
    paste("Sec")
}

# Generates model time difference of a week

weekly_time_diff <- function(){
  # Time difference of models on monday.    
  report <- get_csv_file("data/monday.csv")
  mon <- model_time_diff(report)
  # Time difference of models on tuesday.  
  report <- get_csv_file("data/tuesday.csv")
  tue <- model_time_diff(report)
  # Time difference of models on wednesday.  
  report <- get_csv_file("data/wednesday.csv")
  wed <- model_time_diff(report)
  # Time difference of models on thursday.  
  report <- get_csv_file("data/thursday.csv")
  thu <- model_time_diff(report)
  # Time difference of models on friday.  
  report <- get_csv_file("data/friday.csv")
  fri <- model_time_diff(report)
  # Time difference of models on saturday.  
  report <- get_csv_file("data/saturday.csv")
  sat <- model_time_diff(report)
  # Time difference of models on sunday.  
  report <- get_csv_file("data/sunday.csv")
  sun <- model_time_diff(report)
  
  df <- tibble::tibble(
    Monday = mon,
    Tuesday = tue,
    Wednesday = wed,
    Thursday = thu,
    Friday = fri,
    Saturday = sat,
    Sunday = sun,
  )
  return(df)
}
