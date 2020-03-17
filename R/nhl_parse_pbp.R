#' Parse NHL play by play JSON files
#'
#' This function parses the JSON file and returns a flattened dataframe for the plays and related data.
#' @param gid character, length 1.  The NHL gameid
#' @export
#' @examples
#' nhl_parse_pbp()


sports_parse_pbp(gid='2019020010') {
  # url
  URL = 'http://statsapi.web.nhl.com/api/v1/game/%s/feed/live'
  URL = sprintf(URL, gid)
  # fail function
  fail_function = function() {
    return(data.frame())
  }
  # get the pbp data for the gid
  events = jsonlite::fromJSON(URL)
  # fail gracefully as a dataframe
  # TODO: better way?
  if (! 'copyright' %in% names(events)) {
    fail_function()
  }
  if (length(events) < 1) {
    fail_function()
  }
  # filter down to the plays
  plays = events$liveData$plays$allPlays
  plays2 = jsonlite::flatten(plays)

  # extract players to flatten
  players = plays2$players
  plays2$players = NULL

  # for each entry, if players, for player in , 1 row dataframe
  flatten_players = function(x) {
    if (length(x) == 0) {
      return(data.frame)
  }

  # alskdjf



  }
  # add to plays2
  # clean . in names with _

  # iterate over each

  # --------- result
  test = 'result'




}
