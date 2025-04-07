#' Clean TRN
#'
#' Current limitations:
#' - Single TRN
#' - Only "ANZCTR", "ClinicalTrials.gov", "DRKS", "ISRCTN", "JapicCTI", "EudraCT", "NTR", "PACTR"
#'
#' @param trn Character. A single (messy) TRN. Note: Function tested on single TRN input only, so could perform unexpectedly if run on text with other pattern matches or multiple TRNs.
#' @param registry Character. Registry of TRN. Default to NULL and detected to TRN. Note: Currently, always set registry to NULL because would need further input validation.
#' @param quiet Logical. Whether to inform user if TRN changed (and only when TRN changed). Defaults to TRUE.
#'
#' @return Cleaned TRN. If error (e.g., if no trn input or registry not in cleaning list), aborts (could change to inform and return NA). If input trn already clean, return is same as input. If TRN is NA, return NA.
#' @export
#'
#' @examples
#'
#'\dontrun{
#'# Error due to invalid TRN or registry not in
#'clean_trn("nl)277")
#'clean_trn("IRCT2016080318745N10")
#'}
#'# Already clean so won't inform user
#'clean_trn("NCT01208194")
#'# Cleaned so will inform user unless quiet == TRUE
#'clean_trn("nCt01208194")
#'clean_trn("nCt01208194", quiet = TRUE)
#'
#'clean_trn("DRKS 00003170")
#'clean_trn("ISRCTN 02452400")
#'clean_trn("PACTR 2010020001429343")
#'clean_trn("EudraCT 2004-002714-11")
#'clean_trn("2020-001934-37-ES")

clean_trn <- function(trn, registry = NULL, quiet = FALSE){

  # Note: would need further tests to handle incorrect user-supplied registry,
  # E.g., clean_trn("NCT01208194", "DRKS")
  registry = NULL

  # If trn is na, return na
  if (is.na(trn)) {return(NA_character_)}

  # If registry not provided, detect registry
  if (rlang::is_null(registry)){

    registry <-
      ctregistries::registries |>
      dplyr::filter(stringr::str_detect(trn, .data$trn_regex)) |>
      dplyr::pull(registry)

    # Return NA if no trn match
    if (rlang::is_empty(registry)) {
      rlang::abort(
        glue::glue("Invalid TRN. Could not determine registry.: {trn}")
      )
    }
  }

  # If registry not one of those included for cleaning, abort (so I can add to cleaning)
  cleaning_registries <-
    c("ANZCTR", "ChiCTR", "ClinicalTrials.gov", "CRiS", "CTRI", "DRKS", "IRCT", "ISRCTN", "JapicCTI", "jRCT", "EudraCT", "LBCTR", "NTR", "PACTR", "ReBec", "RPCEC", "UMIN-CTR")

  if (!registry %in% cleaning_registries){
    rlang::abort(
      glue::glue(
        "`registry` must be one of: ",
        glue::glue_collapse(cleaning_registries, sep = ", "),
        "\nNot {registry}"
      )
    )
  }

  trn_cleaned <- switch(
    registry,
    "ANZCTR" = glue::glue("ACTRN", stringr::str_extract(trn, "126\\d{11}")),
    "ClinicalTrials.gov" = glue::glue("NCT", stringr::str_extract(trn, "0\\d{7}")),
    # Note: This may not work for ids with intervening letters
    # TODO: additional tests
    "ChiCTR" = glue::glue("ChiCTR", stringr::str_extract(trn, "\\d*$")),
    "CRiS" = glue::glue("KCT", stringr::str_extract(trn, "00\\d{5}")),
    "CTRI" = glue::glue(
      "CTRI",
      stringr::str_replace_all(trn, "\\s", "") |>
        stringr::str_extract("/20\\d{2}/\\d{2,3}/0\\d{5}")
    ),
    "DRKS" = glue::glue("DRKS", stringr::str_extract(trn, "000\\d{5}")),
    "IRCT" = glue::glue("IRCT", stringr::str_extract(trn, "20\\d{10,12}N\\d{1,3}")),
    "ISRCTN" = glue::glue("ISRCTN", stringr::str_extract(trn, "\\d{8}")),
    "jRCT" = glue::glue("jRCT", stringr::str_extract(trn, "\\d{9,10}")),
    "JapicCTI" = glue::glue("JapicCTI-", stringr::str_extract(trn, "\\d{6}")),
    "LBCTR" = glue::glue("LBCTR", stringr::str_extract(trn, "20\\d{8}")),
    "PACTR" = glue::glue("PACTR", stringr::str_extract(trn, "20\\d{13,14}")),
    "ReBec" = glue::glue("RBR-", stringr::str_extract(trn, "\\d\\w{5}")),
    "RPCEC" = glue::glue("RPCEC", stringr::str_extract(trn, "0{5}\\d{3}")),
    "UMIN-CTR" = glue::glue("UMIN", stringr::str_extract(trn, "0000\\d{5}")),

    # NTR could start with "NL" or "NTR" depending on new or old id, so just remove spaces
    "NTR" = stringr::str_remove_all(trn, "\\s"),

    "EudraCT" =
      stringr::str_replace_all(
        stringr::str_extract(
          trn,
          "20\\d{2}\\W*0\\d{5}\\W*\\d{2}"
        ),
        "(20\\d{2})\\W*(0\\d{5})\\W*(\\d{2})",
        "\\1-\\2-\\3"
      ) ,
    trn
  )

  # If TRN changed, inform user; don't inform user if no change
  if (trn != trn_cleaned & !quiet){
    rlang::inform(glue::glue("{trn} ({registry}) -> {trn_cleaned}"))
  }

  trn_cleaned
}
