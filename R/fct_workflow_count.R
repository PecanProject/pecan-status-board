#' workflow_count 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd



workflow_count <- function(count){
  nrow(count)
}

header.true <- function(df) {
  names(df) <- as.character(unlist(df[1,]))
  df[-1,]
}

success_count <- function(count){
  df <- as.data.frame(count)
  df <- as.data.frame(df$success_status)
  df <- as.data.frame(table(df))
  df <- df$Freq[2]
}

failure_count <- function(count){
  df <- as.data.frame(count)
  df <- as.data.frame(df$success_status)
  df <- as.data.frame(table(df))
  df <- df$Freq[1]
}