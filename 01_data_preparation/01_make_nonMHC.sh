#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../00_config/config.sh"

mkdir -p "${ROOT}/nonMHC"

# Primary non-MHC sensitivity: chr6:25–34 Mb
awk -v OFS="\t" 'NR==1{print;next}!($2==6 && $3>=25000000 && $3<=34000000)' \
  "${CED_RAW}" > "${ROOT}/nonMHC/CeD_nonMHC.txt"

awk -v OFS="\t" 'NR==1{print;next}!($2==6 && $3>=25000000 && $3<=34000000)' \
  "${HT_RAW}" > "${ROOT}/nonMHC/HT_nonMHC.txt"

# Strict CPASSOC sensitivity: chr6:25–36 Mb
awk -v OFS="\t" 'NR==1{print;next}!($2==6 && $3>=25000000 && $3<=36000000)' \
  "${CED_RAW}" > "${ROOT}/nonMHC/CeD_nonMHC_strict.txt"

awk -v OFS="\t" 'NR==1{print;next}!($2==6 && $3>=25000000 && $3<=36000000)' \
  "${HT_RAW}" > "${ROOT}/nonMHC/HT_nonMHC_strict.txt"

wc -l "${ROOT}/nonMHC/"*.txt
