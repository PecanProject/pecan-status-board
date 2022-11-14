#' error_log 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd


# Get Details of Logs

last_line <- function(txt,n,...){   
  inp <- file(txt)
  open(inp)
  output <- scan(inp,n,what="char(0)",sep="\n",quiet=TRUE,...)
  
  while(TRUE){
    tmp <- scan(inp,1,what="char(0)",sep="\n",quiet=TRUE)
    if(length(tmp)==0) {close(inp) ; break }
    output <- c(output[-1],tmp)
  }
  output
}
