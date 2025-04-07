#' Mutate new column for trial registration number and registry based on specified column

#' @param data A dataframe.
#' @param by Column (bare name) in which to search for trn's (and to join by)
#' @param .keep (Optional) Keep rows without trn's. Defaults to TRUE.

#' @return A dataframe, with "trn" and "databank" columns
#'
#' @importFrom rlang .data
#' @export
#' @examples
#' mutate_trn_registry(sample_trn_df, text)
#' mutate_trn_registry(sample_trn_df, text, .keep = FALSE)

mutate_trn_registry <- function(data, by, .keep = TRUE) {

  data |>

    fuzzyjoin::regex_join(
      dplyr::select(ctregistries::registries, .data$registry, .data$trn_regex),
      rlang::set_names("trn_regex", rlang::ensym(by)),
      ignore_case = TRUE,
      mode = ifelse(.keep == TRUE, "left", "inner") # Filter join to remove non-trn
    ) |>

    dplyr::mutate(trn = stringr::str_extract_all({{by}}, .data$trn_regex)) |>
    tidyr::unnest(.data$trn) |>
    dplyr::select(-.data$trn_regex)
}
