#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../00_config/config.sh"

OUT="${ROOT}/gnova"
mkdir -p "${OUT}"

# Example GNOVA calls. Adjust option names if required by the local GNOVA release.

python "${GNOVA_CALCULATE}"   --sumstats1 "${OUT}/CeD_gnova.txt"   --sumstats2 "${OUT}/HT_gnova.txt"   --bfile "${GNOVA_REF}"   > "${OUT}/CeD_HT_whole.log" 2>&1

python "${GNOVA_CALCULATE}"   --sumstats1 "${OUT}/CeD_nonMHC_gnova.txt"   --sumstats2 "${OUT}/HT_nonMHC_gnova.txt"   --bfile "${GNOVA_REF}"   > "${OUT}/CeD_HT_nonMHC.log" 2>&1
