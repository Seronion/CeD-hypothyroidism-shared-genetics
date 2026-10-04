# Shared genetic architecture between celiac disease and hypothyroidism

This repository contains the analysis code supporting the study **“Cross-trait genomic analyses reveal shared genetic architecture between celiac disease and hypothyroidism.”**

The project integrates complementary GWAS-based approaches to characterize shared susceptibility between **celiac disease (CeD)** and **hypothyroidism**, from genome-wide polygenic sharing to local covariance, shared loci, tissue/cell enrichment, transcriptome-informed gene prioritization, colocalization, and bidirectional Mendelian randomization.

## Study overview

The analytical framework includes:

1. **Genome-wide genetic sharing**
   - LD Score Regression (LDSC)
   - GNOVA
   - MiXeR
2. **Local genetic covariance**
   - rho-HESS
3. **Cross-trait locus discovery**
   - MTAG
   - CPASSOC
4. **Regional signal refinement**
   - GWAS–GWAS colocalization
5. **Shared biological context**
   - stratified LD Score Regression (S-LDSC)
6. **Transcriptome-integrated gene prioritization**
   - SMR/HEIDI
   - FUSION TWAS
   - GTEx v8 eQTL colocalization
7. **Directionality**
   - bidirectional two-sample Mendelian randomization

Whole-genome analyses were treated as the primary analyses. MHC-excluded analyses were used as sensitivity analyses to assess whether shared genetic signals persisted outside the extended major histocompatibility complex.

## GWAS datasets

### Celiac disease
- Source: **FinnGen**
- Cases: **4,115**
- Controls: **394,391**
- Total N: **398,506**
- Ancestry: predominantly European

### Hypothyroidism
- Cases: **51,194**
- Controls: **443,383**
- Total N: **494,577**
- Source: Mathieu et al., *iScience* (2022)
- PMID: **36093044**

The hypothyroidism phenotype is broader than Hashimoto thyroiditis and should therefore not be interpreted as a Hashimoto-specific GWAS.

## Repository structure

```text
CeD_HT_shared_genetics_code/
├── README.md
├── CITATION.cff
├── .gitignore
├── PUBLIC_RELEASE_CHECKLIST.md
├── MANUSCRIPT_METHODS_MAP.md
├── 00_config/
├── 01_data_preparation/
├── 02_global_genetic_sharing/
│   ├── LDSC/
│   ├── GNOVA/
│   ├── MTAG/
│   └── MiXeR/
├── 03_local_genetic_covariance/
│   └── rhoHESS/
├── 04_cross_trait_loci/
│   └── CPASSOC/
├── 05_colocalization/
│   ├── GWAS_GWAS/
│   └── eQTL/
├── 06_tissue_enrichment/
│   └── S_LDSC/
├── 07_transcriptomic_integration/
│   ├── SMR/
│   └── TWAS/
├── 08_MR/
├── 09_figures/
├── 10_tables/
└── 11_environment/
```

`MANUSCRIPT_METHODS_MAP.md` links each Methods subsection of the manuscript to the corresponding code directory.

## Key analysis parameters

### Non-MHC sensitivity analyses
- Primary extended MHC exclusion: **chr6:25–34 Mb**
- Strict CPASSOC sensitivity exclusion: **chr6:25–36 Mb**

### CPASSOC
- Cross-trait genome-wide significance: **P<sub>SHet</sub> < 5 × 10⁻⁸**
- LD clumping:
  - `r² = 0.20`
  - window = `500 kb`
  - European 1000 Genomes reference panel

### Mendelian randomization
Genetic instruments were selected using:
- genome-wide significance: **P < 5 × 10⁻⁸**
- LD clumping:
  - `r² = 0.001`
  - window = `10,000 kb`
- European 1000 Genomes reference panel

The inverse-variance weighted method was used as the primary estimator, with MR-Egger, weighted median, simple mode, and weighted mode as sensitivity analyses. Heterogeneity was assessed using Cochran’s Q statistic and directional horizontal pleiotropy using the MR-Egger intercept.

### Transcriptome-integrated analyses
Shared candidate genes were prioritized using complementary evidence from:
- SMR with **FDR < 0.05**
- HEIDI with **P<sub>HEIDI</sub> > 0.01**
- TWAS with **FDR < 0.05**
- pairwise GWAS–eQTL colocalization

Colocalization is interpreted as evidence for shared association signals rather than proof of a shared causal variant.

## Reproducibility

A typical analysis sequence is:

```bash
# 1. Configure paths
nano 00_config/config.sh

# 2. Prepare non-MHC sensitivity datasets
bash 01_data_preparation/01_make_nonMHC.sh

# 3. Genome-wide sharing
bash 02_global_genetic_sharing/LDSC/run_ldsc_rg.sh
bash 02_global_genetic_sharing/GNOVA/prepare_gnova.sh
bash 02_global_genetic_sharing/MTAG/run_mtag_nonMHC.sh

# 4. Local covariance and cross-trait loci
python 03_local_genetic_covariance/rhoHESS/filter_fdr.py \
  --input /path/to/hess_results.txt \
  --output /path/to/hess_fdrsig.txt

bash 04_cross_trait_loci/CPASSOC/plink_clump_strict_nonMHC.sh

# 5. Transcriptome-integrated analyses
bash 07_transcriptomic_integration/SMR/run_smr_gtex.sh
bash 07_transcriptomic_integration/TWAS/run_fusion_twas.sh

# 6. Bidirectional MR
Rscript 08_MR/run_bidirectional_MR.R
```

Paths in the repository are examples and should be adapted to the local computing environment. The repository is intended to document the analytical workflow and key parameterization used in the study rather than reproduce the original server directory structure exactly.

## Software

The workflow uses:
- PLINK
- R
- Python
- LDSC
- GNOVA
- MiXeR
- rho-HESS
- MTAG
- CPASSOC
- SMR
- FUSION/TWAS
- coloc
- TwoSampleMR
- ieugwasr

Exact software versions may be added to `11_environment/software_versions_TEMPLATE.txt` when required by the target journal or for an archived release.

## Data availability

This repository contains analysis code only. It does **not** redistribute individual-level genotype data, full GWAS summary statistics, or large third-party reference datasets.

Data/resources used in the workflow include:
- **Celiac disease:** FinnGen GWAS summary statistics.
- **Hypothyroidism:** Mathieu et al., *iScience* (2022), PMID 36093044.
- **Gene expression:** GTEx v8 eQTL resources.
- **LD reference data:** European ancestry 1000 Genomes resources.
- **LDSC/S-LDSC resources:** externally obtained LD-score and annotation files.

Users should obtain these datasets directly from the corresponding data providers and comply with their applicable access conditions and terms of use.

No individual-level participant data are included in this repository.

## Main outputs represented in the repository

The code corresponds to analyses reported in the manuscript, including:
- genome-wide genetic correlation and polygenic overlap;
- local genetic covariance;
- cross-trait susceptibility loci;
- regional GWAS–GWAS colocalization;
- tissue and cell-type enrichment;
- SMR/TWAS/eQTL-colocalization gene prioritization;
- bidirectional Mendelian randomization;
- generation of the study workflow and main manuscript figures.

A compact table of selected final values used for manuscript checking is provided at:

```text
10_tables/known_final_results.tsv
```

This file is included for reproducibility and quality control and is not intended to replace the full study results.

## Citation

If you use this code, please cite the associated study:

> Li J, Tong S, Li Z. **Cross-trait genomic analyses reveal shared genetic architecture between celiac disease and hypothyroidism.** Manuscript in preparation.

Repository:

> https://github.com/Seronion/CeD-hypothyroidism-shared-genetics

GitHub will also display a **Cite this repository** option using the included `CITATION.cff` file.

## Code availability statement

> Analysis code used in this study is publicly available at https://github.com/Seronion/CeD-hypothyroidism-shared-genetics.

## License

No open-source license is assigned in this package by default. Before public release, the authors can add a license that matches their intended reuse policy.

## Contact

For questions about the analysis code, please use the GitHub Issues page:

> https://github.com/Seronion/CeD-hypothyroidism-shared-genetics/issues
