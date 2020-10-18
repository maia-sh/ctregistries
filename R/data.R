#' Trial registries and other databanks in MEDLINE and WHO's ICTRP
#'
#' A dataset containing the trial registries and other databanks in MEDLINE Databank Sources and World Health Organization (WHO) International Clinical Trials Registry Platform (ICTRP) Primary Registries. Regular expressions (regexes) for trial registration numbers (TRN). Regexes were developed and tested on 10,000 PubMed records. See [ADD-INFO].
#'
#' @format A data frame with 44 rows and 8 variables:
#' \describe{
#'   \item{databank}{databank name abbreviation}
#'   \item{databank_full_name}{databank full name}
#'   \item{medline_start_date}{start date for inclusion of databank as MEDLINE secondary identifier}
#'   \item{databank_type}{registry, registry_network, other}
#'   \item{trn_regex}{regular expression for registries, not for other databanks}
#'   \item{medline_si}{is this registry indexed as a MEDLINE secondary identifier?}
#'   \item{who_ictrp_primary_registry}{is this registry a WHO ICTRP primary registry?}
#'   \item{registry_website}{registry website}
#' }
#' @source \url{https://www.who.int/ictrp/network/primary/en/}
#' @source \url{https://www.nlm.nih.gov/bsd/medline_databank_source.html}
"databanks"

#' Regexes for trial registries from WHO's ICTRP and MEDLINE
#'
#' A dataset containing the regular expressions (regexes) for trial registration numbers (TRN) from World Health Organization (WHO) International Clinical Trials Registry Platform (ICTRP) Primary Registries and MEDLINE Databank Sources. Regexes were developed and tested on 10,000 PubMed records. See [ADD-INFO].
#'
#' @format A data frame with 21 rows and 8 variables:
#' \describe{
#'   \item{registry}{registry name abbreviation}
#'   \item{databank_full_name}{databank full name}
#'   \item{medline_start_date}{start date for inclusion of databank as MEDLINE secondary identifier}
#'   \item{databank_type}{registry, registry_network, other}
#'   \item{trn_regex}{regular expression for registries, not for other databanks}
#'   \item{medline_si}{is this registry indexed as a MEDLINE secondary identifier?}
#'   \item{who_ictrp_primary_registry}{is this registry a WHO ICTRP primary registry?}
#'   \item{registry_website}{registry website}
#' }
#' @source \url{https://www.who.int/ictrp/network/primary/en/}
#' @source \url{https://www.nlm.nih.gov/bsd/medline_databank_source.html}
"registries"

#' Sample text dataframe for extracting trn's and registries
#'
#'
#' @format A data frame with 6 rows and 2 variables:
#' \describe{
#'   \item{id}{id number}
#'   \item{text}{string containing trial registration number(s)}
#'   \item{registry_guess}{string containing registry guess for trn}
#' }
"sample_trn_df"
