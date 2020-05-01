#' Slugify text
#'
#' Call this function as an addin to turn text slug friendly.
#'
#' @export
slugify <- function() {

  ctx <- rstudioapi::getActiveDocumentContext()

  if (!is.null(ctx)) {
    selected_text <- ctx$selection[[1]]$text

    selected_text <- stringr::str_to_lower(selected_text)
    selected_text <- stringr::str_replace_all(selected_text, " ", "-")

    rstudioapi::modifyRange(ctx$selection[[1]]$range, selected_text)
  }
}
