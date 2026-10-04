import matplotlib.pyplot as plt
import numpy as np

F=[
("MR-Egger",1.1406,.9657,1.3472),
("Weighted median",1.1756,1.1209,1.2330),
("IVW",1.1745,1.1369,1.2134),
("Simple mode",1.1770,1.1056,1.2529),
("Weighted mode",1.1759,1.1069,1.2492)]

R=[
("MR-Egger",1.3465,1.0899,1.6634),
("Weighted median",1.2523,1.0790,1.4534),
("IVW",1.3324,1.2173,1.4584),
("Simple mode",1.0418,.7610,1.4262),
("Weighted mode",1.1481,.9501,1.3873)]

plt.rcParams["font.family"]="Tinos"
fig=plt.figure(figsize=(9.2,6.4))
gs=fig.add_gridspec(2,1,hspace=.50)

for idx,(data,title,n) in enumerate([
    (F,"A   CeD → hypothyroidism",6),
    (R,"B   Hypothyroidism → CeD",96)
]):
    ax=fig.add_subplot(gs[idx,0])
    y=np.arange(5)[::-1]
    ax.axvline(1,ls="--",lw=1)
    for yy,(m,e,l,h) in zip(y,data):
        ax.errorbar(e,yy,xerr=[[e-l],[h-e]],fmt="o",
                    ms=8 if m=="IVW" else 6,capsize=4,lw=1.4)
    ax.set_yticks(y)
    ax.set_yticklabels([d[0] for d in data])
    ax.set_xlim(.7,1.75)
    ax.set_xlabel("Odds ratio (95% CI)")
    ax.set_title(title,loc="left",fontweight="bold")
    ax.text(.99,.08,f"{n} SNPs",transform=ax.transAxes,ha="right")
    for s in ["top","right","left"]:
        ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("Figure5_MR.png",dpi=600,bbox_inches="tight")
fig.savefig("Figure5_MR.pdf",bbox_inches="tight")
fig.savefig("Figure5_MR.svg",bbox_inches="tight")
