#' Check whether each element of input includes a trial registration number

#' @param x A character vector.

#' @return Boolean, length of input
#' @export
#' @examples
#' has_trn(c("NCT00312962", "hello", "euctr2020-001808-42", NA))

has_trn <- function(x) {
  stringr::str_detect(x, paste0(ctregistries::registries$trn_regex,
                                collapse = "|")
  )
}
