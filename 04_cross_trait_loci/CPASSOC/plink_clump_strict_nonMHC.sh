#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../00_config/config.sh"

IN="${ROOT}/cpassoc/CPASSOC_shared_nonMHC.txt"

awk 'BEGIN{OFS="\t"} NR==1{print "SNP","P";next}{print $1,$NF}' "${IN}" \
  > "${ROOT}/cpassoc/cpassoc_for_clump.txt"

"${PLINK}" \
  --bfile "${EUR_BFILE}" \
  --clump "${ROOT}/cpassoc/cpassoc_for_clump.txt" \
  --clump-snp-field SNP \
  --clump-field P \
  --clump-p1 5e-8 \
  --clump-r2 0.20 \
  --clump-kb 500 \
  --out "${ROOT}/cpassoc/strict_nonMHC_clump"
