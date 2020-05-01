#' Create cross reference
#'
#' Call this function as an addin to Create cross reference from clipboard.
#'
#' @export
cross_ref <- function() {

  text <- clipr::read_clip()

  out <- paste0("[", text, "](#", gsub(" ", "-", tolower(text)), ")")

  rstudioapi::insertText(out)
}

