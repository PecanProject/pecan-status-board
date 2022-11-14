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
    read.csv("data/overall-test/monday.csv")
  } else if ((weekdays(Sys.Date())) == "Tuesday") {
    read.csv("data/overall-test/tuesday.csv")
  } else if ((weekdays(Sys.Date())) == "Wednesday") {
    read.csv("data/overall-test/wednesday.csv")
  } else if ((weekdays(Sys.Date())) == "Thursday") {
    read.csv("data/overall-test/thursday.csv")
  } else if ((weekdays(Sys.Date())) == "Friday") {
    read.csv("data/overall-test/friday.csv")
  } else if ((weekdays(Sys.Date())) == "Saturday") {
    read.csv("data/overall-test/saturday.csv")
  } else if ((weekdays(Sys.Date())) == "Sunday") {
    read.csv("data/overall-test/sunday.csv")
  } else {
    read.csv("data/overall-test/test_results.csv")
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

sipnet_report <- function(){
  read.csv("data/sipnet-test/sipnet-test_results.csv")
}

ed2_report <- function(){
    read.csv("data/ed2-test/ed2-test_results.csv")
  }

maespa_report <- function(){
    read.csv("data/maespa-test/maespa-test_results.csv")
}

biocro_report <- function(){
    read.csv("data/biocro-test/biocro-test_results.csv")
  }

basgra_report <- function(){
    read.csv("data/basgra-test/basgra-test_results.csv")
}