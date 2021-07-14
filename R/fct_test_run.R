#' test_run 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#' 
#' @import httr

run_test_dash <- function(){
  print("dsadas")
  headers = c(
    `Accept` = 'application/vnd.github.v3+json',
    `Authorization` = 'token {GITHUB_PAT}' # Replace {GITHUB_PAT} with your Personal Access Token
  )
  
  data = '{"ref":"main"}'
  res <- httr::POST(url = '{Replace with wokflow URL}', httr::add_headers(.headers=headers), body = data) #https://api.github.com/repos/{$user}/{$repo}/actions/workflows/{$workflow_id}/dispatches
}
