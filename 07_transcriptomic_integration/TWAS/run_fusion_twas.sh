#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../00_config/config.sh"

OUT="${ROOT}/TWAS/results"
mkdir -p "${OUT}/CeD" "${OUT}/HT"

CED_SUM="${ROOT}/TWAS/CeD.sumstats"
HT_SUM="${ROOT}/TWAS/HT.sumstats"

TISSUES=(
  Whole_Blood
  Small_Intestine_Terminal_Ileum
  Spleen
  Thyroid
)

for tissue in "${TISSUES[@]}"; do
  Rscript "${FUSION_R}" \
    --sumstats "${CED_SUM}" \
    --weights "${TWAS_WEIGHT}/GTExv8.EUR.${tissue}.pos" \
    --weights_dir "${TWAS_WEIGHT}" \
    --ref_ld_chr "${FUSION_LDREF}" \
    --out "${OUT}/CeD/CeD_${tissue}.dat"

  Rscript "${FUSION_R}" \
    --sumstats "${HT_SUM}" \
    --weights "${TWAS_WEIGHT}/GTExv8.EUR.${tissue}.pos" \
    --weights_dir "${TWAS_WEIGHT}" \
    --ref_ld_chr "${FUSION_LDREF}" \
    --out "${OUT}/HT/HT_${tissue}.dat"
done
