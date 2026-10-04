#!/usr/bin/env python3
import argparse
import pandas as pd
from statsmodels.stats.multitest import multipletests

p=argparse.ArgumentParser()
p.add_argument("--input",required=True)
p.add_argument("--output",required=True)
args=p.parse_args()

d=pd.read_csv(args.input,sep=r"\s+")
if "fdr" not in d.columns:
    d["fdr"]=multipletests(d["p"],method="fdr_bh")[1]
d[d["fdr"]<0.05].to_csv(args.output,sep="\t",index=False)
