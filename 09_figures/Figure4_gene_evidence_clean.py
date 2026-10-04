import matplotlib.pyplot as plt
import numpy as np

genes=["AP003774.1","CCDC88B","PPP1R14B","C2orf74","UBASH3A"]
ced_h4=[.9685,.9631,.9649,.7060,.9899]
ht_h4=[.9977,.9723,.9427,.8425,.0510]
ht_h3=[.05,.04,.06,.13,.9489]

plt.rcParams["font.family"]="Tinos"
fig,ax=plt.subplots(figsize=(8.0,4.8))
ax.set_xlim(-.6,3.6)
ax.set_ylim(-.6,4.6)
y=np.arange(5)[::-1]

for i,yv in enumerate(y):
    ax.scatter(0,yv,s=155,marker="o")
    ax.scatter(1,yv,s=155,marker="o")
    ax.scatter(2,yv,s=155,marker="o" if ced_h4[i]>=.8 else "^")
    if ht_h4[i]>=.8:
        mk="o"
    elif ht_h4[i]>=.5:
        mk="^"
    elif ht_h3[i]>=.8:
        mk="x"
    else:
        mk="o"
    ax.scatter(3,yv,s=165,marker=mk)

ax.set_yticks(y)
ax.set_yticklabels(genes,fontstyle="italic")
ax.set_xticks(range(4))
ax.set_xticklabels(["SMR\nboth traits","TWAS\nboth traits","CeD-eQTL\ncoloc","HT-eQTL\ncoloc"])
for s in ax.spines.values():
    s.set_visible(False)

ax.legend(
    handles=[
        ax.scatter([],[],s=155,marker="o",label="Strong/significant"),
        ax.scatter([],[],s=155,marker="^",label="Suggestive"),
        ax.scatter([],[],s=165,marker="x",label="Distinct signals"),
    ],
    frameon=False,ncol=3,loc="upper center",bbox_to_anchor=(.5,-.14)
)

ax.set_title("Integrated transcriptomic and regulatory evidence",fontweight="bold")
fig.tight_layout()
fig.savefig("Figure4_gene_evidence.png",dpi=600,bbox_inches="tight")
fig.savefig("Figure4_gene_evidence.pdf",bbox_inches="tight")
fig.savefig("Figure4_gene_evidence.svg",bbox_inches="tight")
