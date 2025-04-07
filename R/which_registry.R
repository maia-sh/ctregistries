#' Check which registry(ies) input is from
#'
#' @param x A string (character vector of length 1)
#'
#' @return A string (character vector of length number of registries). Returns NA if no trial registration number detected.
#'
#' @importFrom rlang .data
#' @export
#' @examples
#' which_registry("NCT00312962")
#' which_registry("NCT00312962 and euctr2020-001808-42")
#' which_registry("hello")
#' which_registry(NA)

which_registry <- function(x) {

  registry <-
    ctregistries::registries |>
    dplyr::filter(stringr::str_detect(x, .data$trn_regex)) |>
    dplyr::pull(registry)

  # Return NA if no trn match
  if (rlang::is_empty(registry)) NA_character_ else registry
}

#' Check which registry each element of input is from
#'
#' @param x A character vector.
#' @return A character vector, length of input.
#'
#' @importFrom rlang .data
#' @export
#' @examples
#' which_registries(c("NCT00312962", "hello", "euctr2020-001808-42", NA))
#'
#' df <- dplyr::tibble(trn = c("NCT00312962", "hello", "euctr2020-001808-42", NA))
#' dplyr::mutate(df, registry = which_registries(trn))
#'
#' # Does not work for multiple registries in one element
#' \dontrun{
#' which_registries(c("NCT00312962 and euctr2020-001808-42", "hello", "euctr2020-001808-42", NA))
#' }

which_registries <- function(x) {

  purrr::map_chr(x, which_registry)

}
