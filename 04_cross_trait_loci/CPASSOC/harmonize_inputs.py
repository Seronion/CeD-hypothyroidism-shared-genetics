#!/usr/bin/env python3
import argparse
import pandas as pd

def ambiguous(a,b):
    return {str(a).upper(),str(b).upper()} in ({"A","T"},{"C","G"})

p=argparse.ArgumentParser()
p.add_argument("--ced",required=True)
p.add_argument("--ht",required=True)
p.add_argument("--out",required=True)
args=p.parse_args()

a=pd.read_csv(args.ced,sep=r"\s+")
b=pd.read_csv(args.ht,sep=r"\s+")
a["Z"]=a["beta"]/a["se"]
b["Z"]=b["beta"]/b["se"]

m=a.merge(b,on="SNP",suffixes=("_CeD","_HT"))
rows=[]

for _,r in m.iterrows():
    a1,a2=str(r.A1_CeD).upper(),str(r.A2_CeD).upper()
    b1,b2=str(r.A1_HT).upper(),str(r.A2_HT).upper()

    if ambiguous(a1,a2) or ambiguous(b1,b2):
        continue

    if (a1,a2)==(b1,b2):
        flip=False
    elif (a1,a2)==(b2,b1):
        flip=True
    else:
        continue

    rows.append({
        "SNP":r.SNP,
        "CHR":r.CHR_CeD,
        "BP":r.BP_CeD,
        "A1":a1,
        "A2":a2,
        "beta_CeD":r.beta_CeD,
        "se_CeD":r.se_CeD,
        "Z_CeD":r.Z_CeD,
        "p_CeD":r.p_CeD,
        "beta_HT":-r.beta_HT if flip else r.beta_HT,
        "se_HT":r.se_HT,
        "Z_HT":-r.Z_HT if flip else r.Z_HT,
        "p_HT":r.p_HT
    })

pd.DataFrame(rows).to_csv(args.out,sep="\t",index=False)
