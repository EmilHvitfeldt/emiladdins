#' Insert #benderrule footnote
#'
#' Call this function as an addin to insert a #benderrule footnote
#'
#' @export
bender_rule <- function() {

  out <- "^[[#benderrule](https://thegradient.pub/the-benderrule-on-naming-the-languages-we-study-and-why-it-matters/)]"

  rstudioapi::insertText(out)
}


