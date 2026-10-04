#!/usr/bin/env bash
set -euo pipefail

export ROOT="/path/to/CeD_HT_project"

# GWAS
export CED_RAW="${ROOT}/coeliac_finn38_r10.txt"
export HT_RAW="${ROOT}/hypothyroidism_pmid36093044.txt"

# Confirmed cohort metadata
export CED_CASES=4115
export CED_CONTROLS=394391
export CED_N=398506

export HT_CASES=51194
export HT_CONTROLS=443383
export HT_N=494577

# MHC definitions
export MHC_START=25000000
export MHC_END=34000000
export MHC_STRICT_END=36000000

# LDSC
export LDSC_DIR="/path/to/ldsc"
export LDSC_REF="/path/to/eur_w_ld_chr/"
export HM3_SNPLIST="/path/to/w_hm3.snplist"

# GNOVA
export GNOVA_CALCULATE="/path/to/GNOVA/calculate.py"
export GNOVA_REF="/path/to/GNOVA/reference/eur_chr@_SNPmaf5"

# MTAG
export MTAG_PY="/path/to/mtag/mtag.py"

# PLINK / 1000G EUR
export PLINK="/path/to/plink"
export EUR_BFILE="/path/to/1000G_EUR/EUR"

# SMR
export SMR="/path/to/smr"
export SMR_BFILE="/path/to/1000G.EUR"
export GTEX_BESD="/path/to/GTEx_v8/eQTL_besd_lite"

# TWAS
export FUSION_DIR="/path/to/fusion_twas"
export FUSION_R="${FUSION_DIR}/FUSION.assoc_test.R"
export TWAS_WEIGHT="/path/to/GTEx_TWAS_weights"
export FUSION_LDREF="${FUSION_DIR}/LDREF/1000G.EUR."

mkdir -p "${ROOT}/logs"
