import matplotlib.pyplot as plt
import numpy as np

rows=[
("chr2:202.82-205.80 Mb",1.5954e-4,4.0385e-5),
("chr3:186.89-188.86 Mb",1.8398e-4,3.3981e-5),
("chr6:30.80-31.57 Mb",1.2845e-3,1.2968e-4),
("chr6:31.57-32.68 Mb",1.8949e-3,1.5233e-4),
("chr6:32.68-33.24 Mb",7.9761e-4,1.3588e-4),
("chr6:33.24-35.46 Mb",-3.1354e-4,6.1059e-5),
("chr12:110.34-113.26 Mb",2.0607e-4,4.1305e-5),
]

labels=[r[0] for r in rows]
est=np.array([r[1] for r in rows])*1000
se=np.array([r[2] for r in rows])*1000
y=np.arange(len(rows))[::-1]

plt.rcParams["font.family"]="Tinos"
fig,ax=plt.subplots(figsize=(9.2,5.6))
ax.axvline(0,ls="--",lw=1)
ax.errorbar(est,y,xerr=1.96*se,fmt="o",ms=7,capsize=4,lw=1.4)
ax.set_yticks(y)
ax.set_yticklabels(labels,fontsize=12)
ax.set_xlabel(r"Local genetic covariance ($\times 10^{-3}$)",fontsize=12)
ax.set_title("Local genetic covariance between CeD and hypothyroidism",fontsize=15,fontweight="bold")
ax.grid(axis="x",alpha=.16)
for s in ["top","right","left"]:
    ax.spines[s].set_visible(False)
fig.tight_layout()
fig.savefig("Figure2_rhoHESS.png",dpi=600,bbox_inches="tight")
fig.savefig("Figure2_rhoHESS.pdf",bbox_inches="tight")
fig.savefig("Figure2_rhoHESS.svg",bbox_inches="tight")
