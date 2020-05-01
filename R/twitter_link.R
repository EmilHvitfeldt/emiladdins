#' Create Twitter Link
#'
#' Call this function as an addin to Create a Twitter link from clipboard.
#'
#' @export
twitter_link <- function() {

  text <- clipr::read_clip()

  handle <- gsub("https://twitter.com/", "", text)

  out <- paste0("[", handle, "](", text, ")")

  rstudioapi::insertText(out)
}
