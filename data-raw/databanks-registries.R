library(dplyr)
library(readr)
library(here)

databanks <- readr::read_csv(here("inst", "extdata", "registries.csv"))

databanks <-
  databanks %>%
  dplyr::select(-registry_comments, -format_info)

usethis::use_data(databanks, overwrite = TRUE)

registries <-
  databanks %>%
  dplyr::filter(databank_type == "registry") %>%
  dplyr::rename(registry = databank) %>%
  # dplyr::select(registry, trn_regex) %>%
  # 2021-02-16: Disallow newline \n from non-word \W
  dplyr::mutate(trn_regex = stringr::str_replace_all(trn_regex, stringr::coll("\\W"), "[[:blank:][:punct:]]"))

usethis::use_data(registries, overwrite = TRUE)

# system.file("extdata", "registries.csv", package = "ctregistries")
