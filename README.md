
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ctregistries

*In Development*

<!-- badges: start -->

<!-- badges: end -->

The goal of ctregistries is to facilitate the detection and analysis of
clinical trial registration numbers. ctregistries is primarily a data
package of regular expressions (regexes) and provides some R functions
for implementing the regexes.

Regular expressions were developed for trial registration numbers (TRN)
from World Health Organization (WHO) International Clinical Trials
Registry Platform (ICTRP) Primary Registries
(<https://www.who.int/ictrp/network/primary/en/>) and MEDLINE Databank
Sources (<https://www.nlm.nih.gov/bsd/medline_databank_source.html>).

Additional, non-trial databanks indexed by MEDLINE (e.g., figshare) are
also included, without regexes.

## Installation

You can install the development version of ctregistries from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("maia-sh/ctregistries")
```

## Dataset

ctregistries provides the `registries` dataframe with regular
expressions for each registry. The `registries` dataframe is a subset of
the larger `databanks` dataframe which additionally includes non-trial
databanks indexed by MEDLINE (e.g., figshare) without regexes.
`registries` is created by filtering `databanks` for `databank_type ==
"registry`.

``` r
library(ctregistries)

head(registries) %>% knitr::kable()
```

| registry           | databank\_full\_name                                     | medline\_start\_date | databank\_type | trn\_regex         | medline\_si | who\_ictrp\_primary\_registry | registry\_website                                            |
| :----------------- | :------------------------------------------------------- | -------------------: | :------------- | :----------------- | :---------- | :---------------------------- | :----------------------------------------------------------- |
| ANZCTR             | Australian New Zealand Clinical Trials Registry          |                 2014 | registry       | (?i)(ACTRN|ANZCTR) | TRUE        | TRUE                          | <https://www.anzctr.org.au/>                                 |
| ChiCTR             | Chinese Clinical Trials Registry                         |                 2014 | registry       | (?i)ChiCTR(|)      | TRUE        | TRUE                          | <http://www.chictr.org.cn/>                                  |
| CRiS               | Clinical Research Information Service, Republic of Korea |                 2014 | registry       | (?i)KCT            | TRUE        | TRUE                          | <http://cris.nih.go.kr/cris/en/use_guide/cris_introduce.jsp> |
| ClinicalTrials.gov | ClinicalTrials.gov Database (NIH/NLM)                    |                 2005 | registry       | (?i)NCT            | TRUE        | FALSE                         | <https://clinicaltrials.gov/>                                |
| CTRI               | Clinical Trials Registry - India                         |                 2014 | registry       | (?i)CTRI///        | TRUE        | TRUE                          | <http://ctri.nic.in/>                                        |
| DRKS               | German Clinical Trials Register                          |                 2014 | registry       | (?i)DRKS           | TRUE        | TRUE                          | <http://www.germanctr.de/>                                   |

``` r

databanks$databank
#>  [1] "ANZCTR"             "ChiCTR"             "CRiS"              
#>  [4] "ClinicalTrials.gov" "CTRI"               "DRKS"              
#>  [7] "EudraCT"            "IRCT"               "ISRCTN"            
#> [10] "JapicCTI"           "JMACCT"             "JPRN"              
#> [13] "jRCT"               "LBCTR"              "NTR"               
#> [16] "PACTR"              "ReBec"              "REPEC"             
#> [19] "RPCEC"              "SLCTR"              "TCTR"              
#> [22] "UMIN-CTR"           "BioProject"         "dbGaP"             
#> [25] "dbSNP"              "dbVar"              "Dryad"             
#> [28] "figshare"           "GDB"                "GENBANK"           
#> [31] "GEO"                "OMIM"               "PDB"               
#> [34] "PIR"                "PubChem-BioAssay"   "PubChem-Compound"  
#> [37] "PubChem-Substance"  "RefSeq"             "SRA"               
#> [40] "SWISSPROT"          "UniMES"             "UniParc"           
#> [43] "UniProtKB"          "UniRef"
```

## Functions

ctregistries provides some functions implementing the `registries`
dataset to detect trial registration numbers and registries in both
vectors and dataframes.

``` r
library(ctregistries)

# Check whether there is a TRN
has_trn(c("NCT00312962", "hello", "euctr2020-001808-42", NA))
#> [1]  TRUE FALSE  TRUE    NA

# Extract the TRNs
which_trn("NCT00312962 and euctr2020-001808-42")
#> [1] "NCT00312962"    "2020-001808-42"
which_trns(c("NCT00312962", "hello", "euctr2020-001808-42", NA))
#> [1] "NCT00312962"    NA               "2020-001808-42" NA

# Identify the registry
which_registry("NCT00312962 and euctr2020-001808-42")
#> [1] "ClinicalTrials.gov" "EudraCT"
which_registries(c("NCT00312962", "hello", "euctr2020-001808-42", NA))
#> [1] "ClinicalTrials.gov" NA                   "EudraCT"           
#> [4] NA

# Add the trn and registry to a dataframe
mutate_trn_registry(sample_trn_df, text)
#> # A tibble: 7 x 5
#>      id text                               registry_guess   registry    trn     
#>   <dbl> <chr>                              <chr>            <chr>       <chr>   
#> 1     1 NCT00312962                        clinicaltrials.… ClinicalTr… NCT0031…
#> 2     2 hello                              <NA>             <NA>        <NA>    
#> 3     3 <NA>                               ChiCTR           <NA>        <NA>    
#> 4     4 euctr2020-001808-42                EudraCT          EudraCT     2020-00…
#> 5     5 German Clinical Trial Registry Id… DRKS             DRKS        DRKS000…
#> 6     6 ClinicalTrials.gov number, NCT002… ISRCTN           ClinicalTr… NCT0026…
#> 7     6 ClinicalTrials.gov number, NCT002… ISRCTN           ISRCTN      ISRCTN7…
```

## To Do

  - [ ] Add checks within functions
      - [ ] Check input variable type
      - [ ] Check input (column) name conflicts (e.g., databank,
        trn\_regex)
  - [ ] Add tests: use\_testthat()
  - [ ] Consider removing `check_registry` since just comparing strings…
  - [ ] Change license (CCBY or AGPL, unclear since partially data
    package)
      - <https://r-pkgs.org/lsicense.html>
      - <https://thinkr-open.github.io/licensing-r/rlicense.html>
      - <https://kbroman.org/pkg_primer/pages/licenses.html>
  - [ ] Get functions to work with multiple and no trns (character(0)
    and NA) in one element
      - rapply(\~ifelse(. == 1,NA,.), how = “replace”)
      - purrr::modify\_if()
      - any(lengths(y) \> 1) \# flatten if max 1 trn per element…but
        issue with character(0)
