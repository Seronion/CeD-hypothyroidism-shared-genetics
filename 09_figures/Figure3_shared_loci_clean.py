import matplotlib.pyplot as plt
import numpy as np

loci=["chr2\nrs7588874","chr3\nrs2030519","chr12\nrs3184504"]
p=np.array([5.936e-10,7.7894e-71,2.6678e-141])
lp=-np.log10(p)
h4=np.array([0.0256584,0.7129839,0.99611943])

plt.rcParams["font.family"]="Tinos"
fig=plt.figure(figsize=(10.6,4.8))
gs=fig.add_gridspec(1,2,width_ratios=[1.25,1],wspace=.32)

a=fig.add_subplot(gs[0,0])
y=np.arange(3)[::-1]
a.barh(y,lp,height=.48)
a.axvline(-np.log10(5e-8),ls="--",lw=1)
a.set_yticks(y)
a.set_yticklabels(loci,fontsize=12)
a.set_xlabel(r"$-\log_{10}(P_{\mathrm{SHet}})$")
a.set_title("A   Cross-trait association",loc="left",fontweight="bold")
for s in ["top","right","left"]:
    a.spines[s].set_visible(False)

b=fig.add_subplot(gs[0,1])
x=np.arange(3)
b.bar(x,h4,width=.58)
b.axhline(.8,ls="--",lw=1)
b.set_ylim(0,1.08)
b.set_xticks(x)
b.set_xticklabels(["chr2\nDistinct","chr3\nSuggestive","chr12\nStrong"])
b.set_ylabel("PP.H4")
b.set_title("B   GWAS-GWAS colocalization",loc="left",fontweight="bold")
for xi,v in zip(x,h4):
    b.text(xi,v+.025,f"{v:.2f}",ha="center")
for s in ["top","right"]:
    b.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("Figure3_shared_loci.png",dpi=600,bbox_inches="tight")
fig.savefig("Figure3_shared_loci.pdf",bbox_inches="tight")
fig.savefig("Figure3_shared_loci.svg",bbox_inches="tight")
