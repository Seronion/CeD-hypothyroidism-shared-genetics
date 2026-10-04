#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../00_config/config.sh"

OUT="${ROOT}/SMR/results"
mkdir -p "${OUT}/CeD" "${OUT}/HT"

CED_GWAS="${ROOT}/SMR/cedinput_clean_dedup.txt"
HT_GWAS="${ROOT}/SMR/htinput.txt"

TISSUES=(
  Whole_Blood
  Small_Intestine_Terminal_Ileum
  Spleen
  Thyroid
)

for tissue in "${TISSUES[@]}"; do
  "${SMR}" \
    --bfile "${SMR_BFILE}" \
    --gwas-summary "${CED_GWAS}" \
    --beqtl-summary "${GTEX_BESD}/${tissue}" \
    --diff-freq-prop 0.1 \
    --thread-num 10 \
    --out "${OUT}/CeD/CeD_${tissue}"

  "${SMR}" \
    --bfile "${SMR_BFILE}" \
    --gwas-summary "${HT_GWAS}" \
    --beqtl-summary "${GTEX_BESD}/${tissue}" \
    --diff-freq-prop 0.1 \
    --thread-num 10 \
    --out "${OUT}/HT/HT_${tissue}"
done
