#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(data.table))

args <- commandArgs(trailingOnly=TRUE)
if (length(args)<2) stop("Usage: filter_twas_fdr.R input.dat output.txt")

d <- fread(args[1])
pcol <- if ("TWAS.P" %in% names(d)) "TWAS.P" else if ("P" %in% names(d)) "P" else stop("No TWAS P column")
d[, FDR := p.adjust(get(pcol), method="BH")]
fwrite(d[FDR<0.05], args[2], sep="\t")
