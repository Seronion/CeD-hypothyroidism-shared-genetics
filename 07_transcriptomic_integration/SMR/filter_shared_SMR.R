#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(data.table))

args <- commandArgs(trailingOnly=TRUE)
if (length(args)<3) stop("Usage: filter_shared_SMR.R CeD.smr HT.smr out.txt")

ced <- fread(args[1])
ht  <- fread(args[2])

ced[, FDR_CeD := p.adjust(p_SMR, method="BH")]
ht[,  FDR_HT  := p.adjust(p_SMR, method="BH")]

ced <- ced[FDR_CeD < 0.05 & p_HEIDI > 0.01]
ht  <- ht[FDR_HT  < 0.05 & p_HEIDI > 0.01]

key <- if ("ProbeID" %in% names(ced)) "ProbeID" else names(ced)[1]
shared <- merge(ced,ht,by=key,suffixes=c("_CeD","_HT"))

fwrite(shared,args[3],sep="\t")
