#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../00_config/config.sh"

mkdir -p "${ROOT}/gnova"

python "$(dirname "$0")/../../01_data_preparation/02_standardize_sumstats.py" \
  --input "${CED_RAW}" \
  --output "${ROOT}/gnova/CeD_gnova.txt"

python "$(dirname "$0")/../../01_data_preparation/02_standardize_sumstats.py" \
  --input "${HT_RAW}" \
  --output "${ROOT}/gnova/HT_gnova.txt"

python "$(dirname "$0")/../../01_data_preparation/02_standardize_sumstats.py" \
  --input "${ROOT}/nonMHC/CeD_nonMHC.txt" \
  --output "${ROOT}/gnova/CeD_nonMHC_gnova.txt"

python "$(dirname "$0")/../../01_data_preparation/02_standardize_sumstats.py" \
  --input "${ROOT}/nonMHC/HT_nonMHC.txt" \
  --output "${ROOT}/gnova/HT_nonMHC_gnova.txt"
