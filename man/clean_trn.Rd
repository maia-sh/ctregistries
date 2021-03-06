% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_trn.R
\name{clean_trn}
\alias{clean_trn}
\title{Clean TRN}
\usage{
clean_trn(trn, registry = NULL, quiet = FALSE)
}
\arguments{
\item{trn}{Character. A single (messy) TRN. Note: Function tested on single TRN input only, so could perform unexpectedly if run on text with other pattern matches or multiple TRNs.}

\item{registry}{Character. Registry of TRN. Default to NULL and detected to TRN. Note: Currently, always set registry to NULL because would need further input validation.}

\item{quiet}{Logical. Whether to inform user if TRN changed (and only when TRN changed). Defaults to TRUE.}
}
\value{
Cleaned TRN. If error (e.g., if no trn input or registry not in cleaning list), aborts (could change to inform and return NA). If input trn already clean, return is same as input. If TRN is NA, return NA.
}
\description{
Current limitations:
- Single TRN
- Only "ANZCTR", "ClinicalTrials.gov", "DRKS", "ISRCTN", "JapicCTI", "EudraCT", "NTR", "PACTR"
}
\examples{

\dontrun{
# Error due to invalid TRN or registry not in
clean_trn("nl)277")
clean_trn("IRCT2016080318745N10")
}
# Already clean so won't inform user
clean_trn("NCT01208194")
# Cleaned so will inform user unless quiet == TRUE
clean_trn("nCt01208194")
clean_trn("nCt01208194", quiet = TRUE)

clean_trn("DRKS 00003170")
clean_trn("ISRCTN 02452400")
clean_trn("PACTR 2010020001429343")
clean_trn("EudraCT 2004-002714-11")
clean_trn("2020-001934-37-ES")
}
