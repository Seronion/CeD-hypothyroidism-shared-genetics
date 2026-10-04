#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(data.table)
  library(dplyr)
  library(TwoSampleMR)
  library(ieugwasr)
})

# ------------------------------------------------------------------
# FINAL CONFIRMED INSTRUMENT-SELECTION PARAMETERS
# ------------------------------------------------------------------
P_THRESHOLD <- 5e-8
CLUMP_KB <- 10000
CLUMP_R2 <- 0.001

PLINK_BIN <- "/path/to/plink"
EUR_BFILE <- "/path/to/1000G_EUR/EUR"

# ------------------------------------------------------------------
# Exposure preparation
# Expected exposure columns follow TwoSampleMR naming.
# ------------------------------------------------------------------
prepare_and_clump <- function(trait1_exp_dat_pri) {

  trait1_exp_dat_pri$pval.exposure <- as.numeric(trait1_exp_dat_pri$pval.exposure)

  trait1_exp_dat <- trait1_exp_dat_pri[
    trait1_exp_dat_pri$pval.exposure < P_THRESHOLD,
  ]

  dat <- trait1_exp_dat %>%
    transmute(
      rsid = SNP,
      pval = as.numeric(pval.exposure)
    )

  exp_clump <- ld_clump(
    dat = dat,
    clump_kb = CLUMP_KB,
    clump_r2 = CLUMP_R2,
    plink_bin = PLINK_BIN,
    bfile = EUR_BFILE
  )

  trait1_exp_dat <- trait1_exp_dat[
    trait1_exp_dat$SNP %in% exp_clump$rsid,
  ]

  return(trait1_exp_dat)
}

# ------------------------------------------------------------------
# MR after harmonization
# ------------------------------------------------------------------
run_mr <- function(dat, out_prefix) {

  methods <- c(
    "mr_egger_regression",
    "mr_weighted_median",
    "mr_ivw",
    "mr_simple_mode",
    "mr_weighted_mode"
  )

  res <- mr(dat, method_list = methods)
  res_or <- generate_odds_ratios(res)

  fwrite(
    as.data.table(res_or),
    paste0(out_prefix, "_res_withOR.txt"),
    sep = "\t"
  )

  het <- mr_heterogeneity(
    dat,
    method_list = c("mr_egger_regression","mr_ivw")
  )
  fwrite(
    as.data.table(het),
    paste0(out_prefix, "_heterogeneity.txt"),
    sep = "\t"
  )

  pleio <- mr_pleiotropy_test(dat)
  fwrite(
    as.data.table(pleio),
    paste0(out_prefix, "_egger_intercept.txt"),
    sep = "\t"
  )

  loo <- mr_leaveoneout(dat)
  fwrite(
    as.data.table(loo),
    paste0(out_prefix, "_leaveoneout.txt"),
    sep = "\t"
  )

  invisible(list(
    mr=res_or,
    heterogeneity=het,
    pleiotropy=pleio,
    leaveoneout=loo
  ))
}

# Usage:
# 1) load/format exposure and outcome data
# 2) exposure <- prepare_and_clump(exposure)
# 3) dat <- harmonise_data(exposure, outcome, action=2)
# 4) run_mr(dat, "MR/CeD_to_HT")
# 5) repeat after reversing exposure/outcome
