#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../00_config/config.sh"

OUT="${ROOT}/LDSC"
mkdir -p "${OUT}"

python "${LDSC_DIR}/munge_sumstats.py" \
  --sumstats "${CED_RAW}" \
  --snp SNP --a1 A1 --a2 A2 --p p \
  --signed-sumstats beta,0 \
  --N-col n \
  --merge-alleles "${HM3_SNPLIST}" \
  --out "${OUT}/CeD"

python "${LDSC_DIR}/munge_sumstats.py" \
  --sumstats "${HT_RAW}" \
  --snp SNP --a1 A1 --a2 A2 --p p \
  --signed-sumstats beta,0 \
  --N-col n \
  --merge-alleles "${HM3_SNPLIST}" \
  --out "${OUT}/HT"

python "${LDSC_DIR}/ldsc.py" \
  --rg "${OUT}/HT.sumstats.gz,${OUT}/CeD.sumstats.gz" \
  --ref-ld-chr "${LDSC_REF}" \
  --w-ld-chr "${LDSC_REF}" \
  --out "${OUT}/HT_CeD_rg"
