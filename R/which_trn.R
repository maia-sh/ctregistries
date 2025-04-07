#' Extract TRN(s) from input
#'
#' @param x A string (character vector of length 1)
#'
#' @return A string (character vector of length number of registries). Returns NA if no trial registration number detected.
#'
#' @importFrom rlang .data
#' @export
#' @examples
#' which_trn("NCT00312962")
#' which_trn("NCT00312962 and euctr2020-001808-42")
#' which_trn("hello")
#' which_trn(NA)

which_trn <- function(x) {
  # # works if only 1 trn
  # stringr::str_extract(x,paste0(ctregistries::registries$trn_regex,
  #                               collapse = "|"))

  # works for multiple trns
  trn <-
    stringr::str_extract_all(x,
                             paste0(ctregistries::registries$trn_regex,
                                    collapse = "|")#,
                             # simplify = TRUE
    ) |>
    purrr::flatten_chr()

  # Return NA if no trn match
  if (rlang::is_empty(trn)) NA_character_ else trn
}


#' Extract TRN(s) from each element of input
#'
#' @param x A character vector.
#' @return A character vector, length of input.
#'
#' @importFrom rlang .data
#' @export
#' @examples
#' which_trns(c("NCT00312962", "hello", "euctr2020-001808-42", NA))
#'
#' df <- dplyr::tibble(trn = c("NCT00312962", "hello", "euctr2020-001808-42", NA))
#' dplyr::mutate(df, trn_extract = which_trns(trn))
#'
#' # docDoes not work for multiple TRNs in one element
#' \dontrun{
#' which_trns(c("NCT00312962 and euctr2020-001808-41", "hello", "euctr2020-001808-42", NA))
#' }

which_trns <- function(x) {

  purrr::map_chr(x, which_trn)
}
