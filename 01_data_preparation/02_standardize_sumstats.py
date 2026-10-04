#!/usr/bin/env python3
import argparse
import pandas as pd

p=argparse.ArgumentParser()
p.add_argument("--input",required=True)
p.add_argument("--output",required=True)
args=p.parse_args()

d=pd.read_csv(args.input,sep=r"\s+")
required={"SNP","CHR","BP","A1","A2","freq","beta","se","p","n"}
missing=required.difference(d.columns)
if missing:
    raise SystemExit(f"Missing columns: {sorted(missing)}")

d["Z"]=d["beta"]/d["se"]
d["N"]=d["n"]

d[["SNP","CHR","BP","A1","A2","freq","beta","se","p","Z","N"]].to_csv(
    args.output,sep="\t",index=False
)
