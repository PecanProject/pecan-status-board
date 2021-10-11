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
    get_csv_file("data/monday.csv")
  } else if ((weekdays(Sys.Date())) == "Tuesday") {
    get_csv_file("data/tuesday.csv")
  } else if ((weekdays(Sys.Date())) == "Wednesday") {
    get_csv_file("data/wednesday.csv")
  } else if ((weekdays(Sys.Date())) == "Thursday") {
    get_csv_file("data/thursday.csv")
  } else if ((weekdays(Sys.Date())) == "Friday") {
    get_csv_file("data/friday.csv")
  } else if ((weekdays(Sys.Date())) == "Saturday") {
    get_csv_file("data/saturday.csv")
  } else if ((weekdays(Sys.Date())) == "Sunday") {
    get_csv_file("data/sunday.csv")
  } else {
    get_csv_file("data/test_results.csv")
  }
}

select_day <- function(){
  if ((weekdays(Sys.Date())) == "Monday") {
    c("Monday","Sunday","Saturday","Friday","Thursday","Wednesday","Tuesday")
  } else if ((weekdays(Sys.Date())) == "Tuesday") {
    c("Tuesday","Monday","Sunday","Saturday","Friday","Thursday","Wednesday")
  } else if ((weekdays(Sys.Date())) == "Wednesday") {
    c("Wednesday","Tuesday","Monday","Sunday","Saturday","Friday","Thursday")
  } else if ((weekdays(Sys.Date())) == "Thursday") {
    c("Thursday","Wednesday","Tuesday","Monday","Sunday","Saturday","Friday")
  } else if ((weekdays(Sys.Date())) == "Friday") {
    c("Friday","Thursday","Wednesday","Tuesday","Monday","Sunday","Saturday")
  } else if ((weekdays(Sys.Date())) == "Saturday") {
    c("Saturday","Friday","Thursday","Wednesday","Tuesday","Monday","Sunday")
  } else if ((weekdays(Sys.Date())) == "Sunday") {
    c("Sunday","Saturday","Friday","Thursday","Wednesday","Tuesday","Monday")
  } else {
    c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
  }
}

select_tabledata <- function(){
  if ((weekdays(Sys.Date())) == "Monday") {
    c("sites_name", "models_name", "met", "Monday","Sunday","Saturday","Friday","Thursday","Wednesday","Tuesday")
  } else if ((weekdays(Sys.Date())) == "Tuesday") {
    c("sites_name", "models_name", "met","Tuesday","Monday","Sunday","Saturday","Friday","Thursday","Wednesday")
  } else if ((weekdays(Sys.Date())) == "Wednesday") {
    c("sites_name", "models_name", "met","Wednesday","Tuesday","Monday","Sunday","Saturday","Friday","Thursday")
  } else if ((weekdays(Sys.Date())) == "Thursday") {
    c("sites_name", "models_name", "met","Thursday","Wednesday","Tuesday","Monday","Sunday","Saturday","Friday")
  } else if ((weekdays(Sys.Date())) == "Friday") {
    c("sites_name", "models_name", "met","Friday","Thursday","Wednesday","Tuesday","Monday","Sunday","Saturday")
  } else if ((weekdays(Sys.Date())) == "Saturday") {
    c("sites_name", "models_name", "met","Saturday","Friday","Thursday","Wednesday","Tuesday","Monday","Sunday")
  } else if ((weekdays(Sys.Date())) == "Sunday") {
    c("sites_name", "models_name", "met","Sunday","Saturday","Friday","Thursday","Wednesday","Tuesday","Monday")
  } else {
    c("sites_name", "models_name", "met","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
  }
}

