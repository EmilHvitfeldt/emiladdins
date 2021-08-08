#' tidy all importFrom statements
#'
#' When this function is run then all `#' @importFrom package function`
#' statements, in the `R` in the current working directory, will be moved
#' to a file `R/0_imports.R`, cleaned and sorted.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' tidy_importfrom()
#' }
tidy_importfrom <- function() {

  if (!fs::dir_exists("R")) {
    return(invisible())
  }

  if (!fs::file_exists("R/0_imports.R")) {
    fs::file_create("R/0_imports.R")
  }

  files <- fs::dir_ls("R", type = "file", regexp = "*.[rR]$")

  lines <- purrr::map(files, readLines)

  imports <- purrr::map(lines, stringr::str_subset, "#' @importFrom", negate = FALSE)
  lines <- purrr::map(lines,  stringr::str_subset, "#' @importFrom", negate = TRUE)

  imports <- process_imports(imports)

  if (lines[["R/0_imports.R"]][1] != "NULL") {
    lines[["R/0_imports.R"]] <- c("NULL", lines[["R/0_imports.R"]])
  }

  lines[["R/0_imports.R"]] <- c(imports, lines[["R/0_imports.R"]])

  purrr::walk2(lines, files, writeLines)

  return(invisible())
}

process_imports <- function(imports) {
  x <- unlist(imports, use.names = FALSE)
  x <- stringr::str_squish(x)
  x <- stringr::str_remove(x, "#' @importFrom ")

  package <- stringr::str_extract(x, "([^ ]+)")

  functions <- stringr::str_remove(x, "([^ ]+) ")
  functions <- stringr::str_split(functions, " ")
  functions <- split(functions, package)
  functions <- purrr::map(functions, unlist)
  functions <- purrr::map(functions, unique)
  functions <- purrr::map(functions, sort)
  functions <- purrr::map(functions, paste, collapse = " ")
  functions <- purrr::imap(functions, ~ stringr::str_wrap(.x, 80 - 16 - nchar(.y)))
  functions <- purrr::map(functions, stringr::str_split, "\n")
  functions <- purrr::map(functions, unlist)
  functions <- purrr::imap(functions, ~paste("#' @importFrom", .y, .x))

  unlist(functions, use.names = FALSE)
}
