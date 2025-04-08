#' Extract TRN(s) from input
#'
#' @param x A string (character vector of length 1)
#' @param collapse A string. When a collapse string is given, (by default ";"),
#' then the return vector will be collapsed to a single string with the chosen
#' separator string. If collapse is set to "none", the return is a vector with
#' all extracted TRNs instead.
#' @param clean Logical. By default (TRUE), the individual TRNs will also be
#' cleaned with `trn_clean`. Skip cleaning by setting to FALSE.
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
#' which_trn("NCT00312962 and euctr2020-001808-42", collapse = "none")
#' which_trn("NCT 00312962 and euctr2020-001808-42")
#' which_trn("NCT 00312962 and euctr2020-001808-42", clean = FALSE)
#' which_trn("hello") # return NA if nothing was detected
#' which_trn(c("NCT 00312962", NA, "", "hello")) # NAs and empty strings are ignored
#'
which_trn <- function(x, collapse = ";", clean = TRUE) {
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

    if (clean == TRUE) {
      trn <- furrr::future_map_chr(trn,
                                   \(x) clean_trn(x, quiet = TRUE))
    }

    if (collapse != "none") {
      trn <- trn |>
        dplyr::na_if("NA") |>
        dplyr::na_if("") |>
        stats::na.omit() |>
        paste(collapse = collapse)
    }
    return(trn)
  }

}


#' Extract TRN(s) from each element of input
#'
#' @param trn_vec A character vector.
#' @param collapse A string. The returned vector will be collapsed to a single
#' string with the chosen separator string. Cannot be set to NA.
#' @param clean Logical. By default (TRUE), the individual TRNs will also be
#' cleaned with `trn_clean`. Skip cleaning by setting to FALSE.
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
#' # Does not work for multiple TRNs in one element without collapse
#' \dontrun{
#' which_trns(c("NCT00312962 and euctr2020-001808-41", "hello", "euctr2020-001808-42", NA),
#'  collapse = "none")
#' }
#' which_trns(c("NCT 00312962 and euctr2020-001808-41", "hello", "euctr2020-001808-42", NA))
#' which_trns(c("NCT 00312962 and euctr2020-001808-41", "hello", "euctr2020-001808-42", NA),
#'  clean = FALSE)
#'
which_trns <- function(trn_vec, collapse = ";", clean = TRUE) {
  stopifnot("Collapse argument cannot be set to 'none'. Did you mean to use which_trn?" = collapse != "none")
  furrr::future_map_chr(trn_vec, \(x) which_trn(x, collapse = collapse, clean = clean), .progress = TRUE)
}
