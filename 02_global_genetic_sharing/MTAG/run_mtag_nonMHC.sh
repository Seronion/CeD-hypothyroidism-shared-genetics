#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../00_config/config.sh"

OUT="${ROOT}/mtag"
mkdir -p "${OUT}"

python "$(dirname "$0")/prepare_mtag.py" \
  --input "${ROOT}/nonMHC/CeD_nonMHC.txt" \
  --output "${OUT}/CeD_nonMHC_mtag.txt"

python "$(dirname "$0")/prepare_mtag.py" \
  --input "${ROOT}/nonMHC/HT_nonMHC.txt" \
  --output "${OUT}/HT_nonMHC_mtag.txt"

python "${MTAG_PY}" \
  --sumstats "${OUT}/CeD_nonMHC_mtag.txt,${OUT}/HT_nonMHC_mtag.txt" \
  --snp_name snpid \
  --chr_name chr \
  --bpos_name bpos \
  --a1_name a1 \
  --a2_name a2 \
  --freq_name freq \
  --z_name z \
  --p_name pval \
  --n_name n \
  --out "${OUT}/CeD_HT_nonMHC"
