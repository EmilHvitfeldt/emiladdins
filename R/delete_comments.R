#' Deletes comments in selection
#'
#' Call this function as an addin to delete comments in selection.
#'
#' @export
delete_comments <- function() {

  # Gets The active Documeent
  ctx <- rstudioapi::getActiveDocumentContext()

  # Checks that a document is active
  if (!is.null(ctx)) {

    # Extracts selection as a string
    selected_text <- ctx$selection[[1]]$text

    # modify string
    selected_text <- delete_comments_impl(selected_text)

    # replaces selection with string
    rstudioapi::modifyRange(ctx$selection[[1]]$range, selected_text)
  }
}

delete_comments_impl <- function(x) {
  lines <- strsplit(x, "\n")[[1]]

  lines <- lines[!grepl("^\\s*#", lines)]

  paste0(lines, collapse = "\n")
}
