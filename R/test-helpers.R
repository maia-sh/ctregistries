#' Does the object match the registry, and should it match?
#'
#' Test expectation of whether a TRN come from a particular registry using for known true TRNs and TRN errors.
#'
#' @param object Character. Text to test
#' @param reg Character. Name of registry to test \code{object} against.
#' @param match_expected Logical. Whether object should match registry. `TRUE` for true positives. `FALSE` for true negatives.
#'
#' @examples
#' \dontrun{expect_registry("PER-093-09", "REPEC", match_expected = TRUE)}
#' \dontrun{expect_registry("cucumber", "REPEC", match_expected = TRUE)}
#' \dontrun{expect_registry("cucumber", "REPEC", match_expected = FALSE)}
#' \dontrun{expect_registry("PER-093-09", "REPEC", match_expected = FALSE)}

expect_registry <- function(object, reg, match_expected = TRUE) {

  if (!rlang::is_logical(match_expected, n = 1)){
    rlang::abort("`match_expected` must be a logical.")
  }

  act <- testthat::quasi_label(rlang::enquo(object), arg = "object")

  # Check whether object matches reg regex
  trn_regex <-
    ctregistries::registries |>
    dplyr::filter(.data$registry == reg) |>
    dplyr::pull(.data$trn_regex)

  act$match <- stringr::str_detect(act$val, trn_regex)

  # Build expectation based on whether match expected
  if (match_expected) {
    testthat::expect(
      act$match,
      glue::glue("False negative: {act$lab} does not match {reg} registry")
    )
  } else if (!match_expected) {
    testthat::expect(
      !act$match,
      glue::glue("False positive: {act$lab} does match {reg} registry")
    )
  }

  invisible(act$val)

}
