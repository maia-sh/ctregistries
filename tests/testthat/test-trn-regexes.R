# ANZCTR
# ChiCTR
# CRiS
# ClinicalTrials.gov
# CTRI
# DRKS
# EudraCT
# IRCT
# ISRCTN
# JapicCTI
# JMACCT
# jRCT
# LBCTR
# NTR
# PACTR
# ReBec
# REPEC
# RPCEC
# SLCTR
# TCTR
# UMIN-CTR


# ClinicalTrials.gov ------------------------------------------------------

test_that("ClinicalTrials.gov TP detected", {

  tests <- c(
    "NCT01400022",  #10.1001/jamadermatol.2013.7733
    "NCT 00902941", #10.1002/mds.25661
    "nCt01208194",  #10.1007/s00432-014-1682-7
    "NCT#00379470", #10.1016/j.ejca.2012.04.011
    "Nct02529358"   #10.1016/j.jad.2017.10.047
  )

  purrr::walk(
    tests,
    expect_registry, reg = "ClinicalTrials.gov", match_expected = TRUE
  )
})

# test_that("ClinicalTrials.gov TN rejected", {
#   tests <- c(
#
#   )
#
#   purrr::walk(
#     tests,
#     expect_registry, reg = "ClinicalTrials.gov", match_expected = FALSE
#   )
# })

# DRKS --------------------------------------------------------------------

test_that("DRKS TP detected", {

  tests <- c(
    "DRKS00005115", #10.1002/dta.1830
    "DRKS 00003170" #10.1111/jdv.12823
  )

  purrr::walk(
    tests,
    expect_registry, reg = "DRKS", match_expected = TRUE
  )
})

# test_that("DRKS TN rejected", {
#   tests <- c(
#
#   )
#
#   purrr::walk(
#     tests,
#     expect_registry, reg = "DRKS", match_expected = FALSE
#   )
# })

# EudraCT -----------------------------------------------------------------
test_that("EudraCT TP detected", {

  tests <- c(
    "EudraCT 2004-002714-11",
    "2020-001934-37-ES"
  )

  purrr::walk(
    tests,
    expect_registry, reg = "EudraCT", match_expected = TRUE
  )
})

test_that("EudraCT TN rejected", {
  tests <- c(
    # "200400600800", #10.1007/s00394-015-1084-x [ISSUE]
    # "201201801201"  #10.1016/j.jpain.2012.01.003 [ISSUE]
    "PACTR201205000384379" #PMC5278894 (previously matched because of second "20")
  )

  purrr::walk(
    tests,
    expect_registry, reg = "EudraCT", match_expected = FALSE
  )
})


# IRCT --------------------------------------------------------------------

test_that("IRCT TP detected", {

  tests <- c(
    "IRCT2016080318745N10",
    "IRCT2016080818745N11"
  )

  purrr::walk(
    tests,
    expect_registry, reg = "IRCT", match_expected = TRUE
  )
})

test_that("IRCT TN rejected", {
  tests <- c(
    "IRCT20181201041815N"
  )

  purrr::walk(
    tests,
    expect_registry, reg = "IRCT", match_expected = FALSE
  )
})



# ISRCTN ------------------------------------------------------------------

test_that("ISRCTN TP detected", {

  tests <- c(
    "ISRCTN78805636", #10.1007/s00066-014-0737-7
    "ISRCTN 02452400" #10.1097/QAD.0000000000000862
  )

  purrr::walk(
    tests,
    expect_registry, reg = "ISRCTN", match_expected = TRUE
  )
})

test_that("ISRCTN TN rejected", {
  tests <- c(
    "ISCRTN06180958" #10.1136/bmjopen-2019-030110
  )

  purrr::walk(
    tests,
    expect_registry, reg = "ISRCTN", match_expected = FALSE
  )
})

# NTR ---------------------------------------------------------------------

test_that("NTR TP detected", {

  tests <- c(
    "NL9229"
  )

  purrr::walk(
    tests,
    expect_registry, reg = "NTR", match_expected = TRUE
  )
})

test_that("NTR TN rejected", {
  tests <- c(
    "nl-2012-302759", #10.1136/gutjnl-2012-302759
    # "nL6118",         #10.1097/TP.0000000000000779 [ISSUE]
    # "nl11",           #10.1186/cc13089 [ISSUE]
    "NL26560.042.09", #10.1378/chest.11-0730
    "nl)277",         #10.1002/bjs.9387
    "nl [23",         #10.1186/cc13089
    "nL.63",          #10.1199/JCO.2014.55.1481
    "NL. [14",        #10.2147/DDDT.S54064
    "nL)293",         #10.1097/SLA.0b013e318214bee5
    "nl)20",          #10.1186/cc13089
    "NL (17",         #10.3945/jn.113.179390
    "6721"            #10.1136/bmjopen-2019-032488 [ISSUE: currently included]
  )

  purrr::walk(
    tests,
    expect_registry, reg = "NTR", match_expected = FALSE
  )
})


# PACTR -------------------------------------------------------------------

test_that("PACTR TP detected", {

  tests <- c(
    "PACTR 2010020001429343"
  )

  purrr::walk(
    tests,
    expect_registry, reg = "PACTR", match_expected = TRUE
  )
})

# test_that("PACTR TN rejected", {
#   tests <- c(
#
#   )
#
#   purrr::walk(
#     tests,
#     expect_registry, reg = "PACTR", match_expected = FALSE
#   )
# })

test_that("All PACTR digits extracted", {
  expect_equal(which_trn("PACTR 2010020001429343"), "PACTR 2010020001429343")
  expect_equal(which_trn("PACTR202406532417953"), "PACTR202406532417953")
})

# REPEC -------------------------------------------------------------------

test_that("REPEC TP detected", {

  tests <- c(
    "PER-106-20"
  )

  purrr::walk(
    tests,
    expect_registry, reg = "REPEC", match_expected = TRUE
  )
})

test_that("REPEC TN rejected", {
  tests <- c(
    "per 100 000",    #10.1001/jama.2013.5823
    "per 100 00",
    "per 100,00",     #10.1016/j.jalz.2009.04.1231
    "per842 (82"#,     #10.1001/jamainternmed.2016.2514
    # "per41515"        #10.1016/j.jhep.2016.02.043 [ISSUE]
  )

  purrr::walk(
    tests,
    expect_registry, reg = "REPEC", match_expected = FALSE
  )
})


# UMIN-CTR ----------------------------------------------------------------

test_that("UMIN-CTR TP detected", {

  tests <- c(
    "registration no. UMIN000012045", #10.1002/ams2.666
    "previously (UMIN:000000562," #10.1002/ehf2.12765
  )

  purrr::walk(
    tests,
    expect_registry, reg = "UMIN-CTR", match_expected = TRUE
  )
})

test_that("UMIN-CTR TN rejected", {
  tests <- c(
    "ZINC000052955"    #10.1016/j.heliyon.2021.e07803
  )

  purrr::walk(
    tests,
    expect_registry, reg = "UMIN-CTR", match_expected = FALSE
  )
})
