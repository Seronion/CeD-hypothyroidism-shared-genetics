#!/usr/bin/env bash
set -euo pipefail

MIXER_DIR="/path/to/mixer"
JSON_FIT="/path/to/CeD_HT.fit.json"
JSON_TEST="/path/to/CeD_HT.test.json"

python "${MIXER_DIR}/precimed/mixer_figures.py" two \
  --json-fit "${JSON_FIT}" \
  --json-test "${JSON_TEST}" \
  --out CeD_HT_MiXeR \
  --trait1 CeD \
  --trait2 Hypothyroidism \
  --statistic mean std \
  --ext svg
