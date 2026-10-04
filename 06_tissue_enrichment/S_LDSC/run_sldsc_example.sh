#!/usr/bin/env bash
set -euo pipefail

LDSC="/path/to/ldsc.py"
SUMSTATS="/path/to/trait.sumstats.gz"
REF_LD="/path/to/baselineLD."
W_LD="/path/to/weights."
ANNOT="/path/to/tissue_or_celltype_annotations."

python "${LDSC}"   --h2 "${SUMSTATS}"   --ref-ld-chr "${REF_LD},${ANNOT}"   --w-ld-chr "${W_LD}"   --overlap-annot   --frqfile-chr "/path/to/1000G_frq/1000G.EUR.QC."   --out "sldsc_enrichment"
