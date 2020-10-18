library(dplyr)
library(readr)
library(here)

databanks <- readr::read_csv(here("inst", "extdata", "registries.csv"))

databanks <-
  databanks %>%
  select(-registry_comments, -format_info)

usethis::use_data(databanks, overwrite = TRUE)

registries <-
  databanks %>%
  filter(databank_type == "registry") %>%
  rename(registry = databank)

usethis::use_data(registries, overwrite = TRUE)

# system.file("extdata", "registries.csv", package = "ctregistries")
