sample_trn_df <-
  dplyr::tribble(
    ~id, ~text,                 ~registry_guess,
    1,   "NCT00312962",         "clinicaltrials.gov",
    2,   "hello",               NA,
    3,   NA,                    "ChiCTR",
    4,   "euctr2020-001808-42", "EudraCT",
    5,   "German Clinical Trial Registry Identifier: DRKS00004367.", "DRKS",
    6,   "ClinicalTrials.gov number, NCT00268476 , and Current Controlled Trials number, ISRCTN78818544", "ISRCTN"
  )

usethis::use_data(sample_trn_df, overwrite = TRUE)
