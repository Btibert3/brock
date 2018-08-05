#' Generate rasa NLU training data file
#'
#' Take a dataframe and export a json dataset in rasa NLUs format.  The dataframe must contain a column
#' called text, which should represent the questions that you want to tag with intents and entities in the RASA NLU
#' training tool https://rasahq.github.io/rasa-nlu-trainer/.
#' https://nlu.rasa.com/dataformat.html
#' @param dat The dataframe holding the text data for questions
#' @param path character the path/name of the file to be exported. Default is in current directory with a name of train.json
#' @export
#' write_rasa_nlu

write_rasa_nlu = function(dat, path="train.json") {
  ## ensure that the text column is present
  stopifnot("text" %in% colnames(dat))
  ## ensure there is at least one row
  stopifnot(nrow(dat) > 0)
  ## keep the column
  dat2 = dplyr::select(dat, text)
  ## for each row, build the entry
  ## TODO: vectorize and remove for-loop
  rasa = list()
  for (i in 1:nrow(dat2)) {
    rasa[[i]] = list(text=dat2$text[i], intent="", entities=list())
  }
  ## finish the file
  rasa_json = list(rasa_nlu_data=list(common_examples=rasa))
  ## write the file
  jsonlite::write_json(rasa_json, path, auto_unbox=TRUE)
}
