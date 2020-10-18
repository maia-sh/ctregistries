#' Check whether registry associated with TRN is correct
#'
#' For example, "NCT00312962" should be associated with "clinicaltrials.gov". PubMed secondary identifies associate TRNs with registries but occassionally misclassify the registry. For example, \url{https://pubmed.ncbi.nlm.nih.gov/25884819/} misclassifies "NTR1912" with JPRN instead of NTR.
#'
#' Designed to be used following \code{\link{mutate_trn_registry}}.
#'
#' @param new Vector of new (aka correct) registries
#' @param old Vector of old (e.g., associated by PubMed) registries

#' @return A vector of TRUE and FALSE. NAs treated as character, such that if both \code{new} and \code{old} are NA, returns TRUE.
#'
#' @export
#' @examples
#' df <- mutate_trn_registry(sample_trn_df, text)
#'
#' # Use with a vector
#' check_registry(df$registry, df$registry_guess)
#'
#' # Use with a dataframe
#' dplyr::mutate(df, registry_correct = check_registry(registry, registry_guess))

check_registry <- function(new, old) {
  dplyr::if_else(
    stringr::str_detect(stringr::str_replace_na(new),
                        stringr::str_replace_na(old)),
    TRUE, FALSE)
}
