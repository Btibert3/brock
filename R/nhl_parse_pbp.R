#' Parse NHL play by play JSON files
#'
#' This function parses the JSON file and returns a flattened dataframe for the plays and related data.
#' @param gid character, length 1.  The NHL gameid
#' @export
#' @examples
#' nhl_parse_pbp()

nhl_parse_pbp = function(gid='2019020010') {
  # url
  URL = 'http://statsapi.web.nhl.com/api/v1/game/%s/feed/live'
  URL = sprintf(URL, gid)
  # fail function
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

  # extract the players and build a dataframe with a row for each play
  players_parsed = data.frame()
  for (i in 1:nrow(plays2)) {
    tmp = plays2[i, "players"][[1]]
    if (length(tmp) == 0) {
      players_parsed = dplyr::bind_rows(players_parsed, data.frame(gid=gid))
    } else {
      tmp_players = data.frame(gid = gid)
      for (i in 1:nrow(tmp)) {
        p = jsonlite::flatten(tmp[i, ])
        colnames(p) = paste0(colnames(p), "_", i)
        tmp_players = cbind(tmp_players, p)
      }
      players_parsed = dplyr::bind_rows(players_parsed, tmp_players)
    }
    # cleanup
    # rm(tmp, tmp_players, p)
  }

  # add to plays2
  plays2$players = NULL
  players_parsed$gid = NULL
  plays3 = cbind(plays2, players_parsed)

  # clean . in names with _
  colnames(plays3) = gsub("\\.", "_", colnames(plays3))

  # return the parsed data
  return(plays3)

}

fail_function = function() {
  return(data.frame())
}


fail_function = function() {
  return(data.frame())
}







## test cases
# test_parse = sports_parse_pbp()
# class(test_parse) == 'data.frame'
# nrow(test_parse) > 0
