#' Wraps selected line to fit inside 80 character width
#'
#' @export
#' @importFrom stringr str_remove str_wrap str_split
wrap_roxygen <- function() {

  # Gets The active Documeent
  ctx <- rstudioapi::getActiveDocumentContext()

  # Checks that a document is active
  if (!is.null(ctx)) {

    selection_rows <- c(
      ctx$selection[[1]]$range[[1]][[1]],
      ctx$selection[[1]]$range[[2]][[1]]
    )

    if (length(unique(selection_rows)) == 1) {
      text <- str_remove(ctx$contents[selection_rows[1]], "^#'")
      text <- str_wrap(text, 77)
      change <- paste0("#' ", unlist(str_split(text, "\n")))

      before <- ctx$contents[seq_along(ctx$contents) < selection_rows[1]]
      after <- ctx$contents[seq_along(ctx$contents) > selection_rows[1]]

      new_content <- paste0(c(before, change, after), collapse = "\n")

      rstudioapi::setDocumentContents(new_content, ctx$id)
      rstudioapi::setCursorPosition(
        rstudioapi::document_position(row = length(before)+length(change),
                                      column = nchar(change[length(change)])),
        ctx$id
        )
    }
  }
}
