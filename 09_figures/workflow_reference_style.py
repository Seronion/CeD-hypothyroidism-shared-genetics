import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, FancyArrowPatch

plt.rcParams["font.family"]="Tinos"

fig,ax=plt.subplots(figsize=(13.5,8.0))
ax.set_xlim(0,13.5); ax.set_ylim(0,8.0); ax.axis("off")

COL={
"global":"#FDECEF",
"local":"#FFF3D9",
"tissue":"#EAF5F2",
"risk":"#EAF7FB",
"mr":"#EDF1FF",
"gene":"#EAF7FB",
"edge":"#333333"
}

def box(x,y,w,h,title,subtitle,fc):
    ax.add_patch(Rectangle((x,y),w,h,facecolor=fc,edgecolor="black",lw=1.4))
    ax.text(x+w/2,y+h*.63,title,ha="center",va="center",fontweight="bold",fontsize=13)
    ax.text(x+w/2,y+h*.30,subtitle,ha="center",va="center",fontsize=10.5)

def arrow(x1,y1,x2,y2):
    ax.add_patch(FancyArrowPatch((x1,y1),(x2,y2),arrowstyle="-|>",mutation_scale=12,lw=1.3,color=COL["edge"]))

box(1.0,6.75,4.5,.95,"Celiac disease (CeD)","FinnGen | 4,115 cases | 394,391 controls","#EEF4FF")
box(8.0,6.75,4.5,.95,"Hypothyroidism","51,194 cases | 443,383 controls","#EEF4FF")

box(.55,4.10,3.2,.85,"Global genetic sharing","LDSC / GNOVA / MiXeR",COL["global"])
box(5.15,4.10,3.2,.85,"Local genetic sharing","rho-HESS",COL["local"])
box(9.75,4.10,3.2,.85,"Shared risk loci","MTAG / CPASSOC",COL["risk"])

box(.55,2.45,3.2,.82,"Directionality","Bidirectional MR",COL["mr"])
box(5.15,2.45,3.2,.82,"Shared biological context","S-LDSC",COL["tissue"])
box(9.75,2.45,3.2,.82,"Regional refinement","GWAS-GWAS colocalization",COL["risk"])
box(9.75,1.15,3.2,.82,"Shared candidate genes","SMR / TWAS / eQTL coloc",COL["gene"])

fig.tight_layout()
fig.savefig("workflow.png",dpi=600,bbox_inches="tight")
fig.savefig("workflow.pdf",bbox_inches="tight")
fig.savefig("workflow.svg",bbox_inches="tight")
