#' @export
#' @importFrom glue glue
find_todo <- function() {
  files <- list.files(".", recursive = TRUE, pattern = "[\\.rmd|\\.md|\\.R]$")
  counter <- FALSE
  todo_file <- function(file) {
    lines <- suppressWarnings(readLines(file))
    which_lines <- which(grepl("TODO", lines))
    if(length(which_lines) > 0) {
      counter <- TRUE
      cat(glue("\033[32m{file}\033[39m"))
      cat(glue("\033[35mLine {which_lines}:\033[39m {lines[which_lines]}\n"))
      cat("\n\n")
    }
  }
  if (counter) cat("No TODO's found!")
  invisible(lapply(files, todo_file))
}
