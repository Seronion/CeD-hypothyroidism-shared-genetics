# Bidirectional MR – final confirmed settings

Instrument selection:
- P < 5e-8
- clump_r2 = 0.001
- clump_kb = 10000
- LD reference = 1000 Genomes EUR

PLINK: `/path/to/plink`

Reference bfile: `/path/to/1000G_EUR/EUR`

Final main-direction results:

CeD -> hypothyroidism
- 6 SNPs
- IVW OR 1.1745 (95% CI 1.1369–1.2134)
- P = 3.83e-22

Hypothyroidism -> CeD
- 96 SNPs
- IVW OR 1.3324 (95% CI 1.2173–1.4584)
- P = 4.80e-10

Interpret as MR associations under instrumental-variable assumptions rather than definitive proof of causality.
