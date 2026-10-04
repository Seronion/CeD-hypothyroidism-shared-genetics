#!/usr/bin/env python3
import argparse
import pandas as pd

p=argparse.ArgumentParser()
p.add_argument("--input",required=True)
p.add_argument("--output",required=True)
args=p.parse_args()

d=pd.read_csv(args.input,sep=r"\s+")
o=pd.DataFrame({
    "snpid":d["SNP"],
    "chr":d["CHR"],
    "bpos":d["BP"],
    "a1":d["A1"],
    "a2":d["A2"],
    "freq":d["freq"],
    "z":d["beta"]/d["se"],
    "pval":d["p"],
    "n":d["n"]
})
o.to_csv(args.output,sep="\t",index=False)
