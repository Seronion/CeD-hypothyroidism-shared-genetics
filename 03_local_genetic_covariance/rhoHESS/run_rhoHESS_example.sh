#!/usr/bin/env bash
set -euo pipefail

HESS="/path/to/hess.py"
CED_SUMSTATS="/path/to/CeD_hess_input.txt"
HT_SUMSTATS="/path/to/HT_hess_input.txt"
LD_DIR="/path/to/hess/ld_reference"
OUT="/path/to/output/hess"

mkdir -p "${OUT}"

# Example workflow: estimate local SNP heritability for each trait,
# then combine the trait-specific outputs for local covariance analysis.
# Exact option names can be adapted to the installed HESS release.

python "${HESS}"   --local-hsqg "${CED_SUMSTATS}"   --partition "${LD_DIR}"   --out "${OUT}/CeD"

python "${HESS}"   --local-hsqg "${HT_SUMSTATS}"   --partition "${LD_DIR}"   --out "${OUT}/HT"

# Downstream FDR filtering is performed with filter_fdr.py.
