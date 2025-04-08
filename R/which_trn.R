#' Extract TRN(s) from input
#'
#' @param x A string (character vector of length 1)
#' @param collapse A string. By default, NA, the return is a vector with
#' all extracted TRNs. If a collapse string is given, then the vector will
#' be collapsed to a single string with the chosen separator string.
#'
#' @return A string (character vector of length number of registries or
#'  of length 1, depending on value of collapse).
#'  Returns NA if no trial registration numbers detected.
#'
#' @importFrom rlang .data
#' @export
#' @examples
#' which_trn("NCT00312962")
#' which_trn("NCT00312962 and euctr2020-001808-42")
#' which_trn("NCT00312962 and euctr2020-001808-42", collapse = ";")
#' which_trn("hello")
#' which_trn(NA, NA)

which_trn <- function(x, collapse = NA_character_) {
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

  if (rlang::is_empty(trn)) {
    # Return NA if no trn match
    return(NA_character_)
  } else {
    if (!is.na(collapse)) {
      trn <- paste(trn, collapse = collapse) |>
        dplyr::na_if("NA") |>
        dplyr::na_if("")
    }
    return(trn)
  }

}


#' Extract TRN(s) from each element of input
#'
#' @param trn_vec A character vector.
#' @param collapse A string. By default, NA, the return is a vector with
#' all extracted TRNs. If a collapse string is given, then the vector will
#' be collapsed to a single string with the chosen separator string.
#'
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
#' # docDoes not work for multiple TRNs in one element if no collapse chosen
#' \dontrun{
#' which_trns(c("NCT00312962 and euctr2020-001808-41", "hello", "euctr2020-001808-42", NA))
#' }
#' which_trns(c("NCT00312962 and euctr2020-001808-41", "hello", "euctr2020-001808-42", NA),
#'  collapse = ";")

which_trns <- function(trn_vec, collapse = NA_character_) {

  furrr::future_map_chr(trn_vec, \(x) which_trn(x, collapse = collapse), .progress = TRUE)
}
