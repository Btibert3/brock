#' Cleanup Column Names
#'
#' This function performs common 
#' @param df The dataframe for the columns to be modified in-place
#' @param ws_char character, length 1. The character to be set as the replacement for a space within the column name.
#' @param to_lower logical. Default is TRUE. If TRUE, the column names are set using tolower()
#' @export
#' @examples
#' clean_colnames()

clean_colnames <- function(df, ws_char=NA, to_lower=TRUE){
  x = df
  if(to_lower) {
    colnames(x) = tolower(colnames(x))
  }
  if(!is.na(ws_char)) {
    colnames(x) = gsub(" ", ws_char, colnames(x))
  }
  return(x)
}

## df = data.frame("first name" = NA, "LAST_NAME"= NA)
## colnames(df) = c("First Name", "LAST_NAME")



