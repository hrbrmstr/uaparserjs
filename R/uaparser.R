#' Parse a vector of user agents into a data frame
#'
#' Takes in a character vector of user agent strings and returns a \code{tibble}
#' of parsed user agents.
#'
#' @param user_agents a character vector of user agents
#' @param .progress if \code{TRUE}, will display a progress bar in interactive mode
#' @export
#' @return a \code{tibble} with columns for user agent family, major & minor versions
#'     plus patch level along with os family and major & minor versions plus
#'     device brand and model.
#' @references \url{http://www.uaparser.org/}
#' @note The regex YAML import date: 2016-08-04
#' @examples
#' ua_parse(paste0("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, ",
#'                 "like Gecko) Ubuntu/11.10 Chromium/15.0.874.106 ",
#'                 "Chrome/15.0.874.106 Safari/535.2", collapse=""))
ua_parse <- function(user_agents, .progress=FALSE) {

  if (.progress) pb <- progress_estimated(length(user_agents))
  purrr::map_df(user_agents, function(x) {
    if (.progress) pb$tick()$print()
    res <- .pkgenv$cache[[x]]
    if (length(res) > 0) {
      res
    } else {
      .pkgenv$cache[[x]] <- dplyr::as_data_frame(as.list(unlist(.pkgenv$ctx$call("parser.parse", x))))
      .pkgenv$cache[[x]]
    }
  })

}

#' @export
get_cache <- function() { .pkgenv$cache }