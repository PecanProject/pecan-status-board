#' fetch_data 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#' 

testrun_report <- function(){
  if ((weekdays(Sys.Date())) == "Monday") {
    read.csv("data/monday.csv")
  } else if ((weekdays(Sys.Date())) == "Tuesday") {
    read.csv("data/tuesday.csv")
  } else if ((weekdays(Sys.Date())) == "Wednesday") {
    read.csv("data/wednesday.csv")
  } else if ((weekdays(Sys.Date())) == "Thursday") {
    read.csv("data/thursday.csv")
  } else if ((weekdays(Sys.Date())) == "Friday") {
    read.csv("data/friday.csv")
  } else if ((weekdays(Sys.Date())) == "Saturday") {
    read.csv("data/saturday.csv")
  } else if ((weekdays(Sys.Date())) == "Sunday") {
    read.csv("data/sunday.csv")
  } else {
    read.csv("data/test_results.csv")
  }
}

