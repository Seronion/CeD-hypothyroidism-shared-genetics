#!/usr/bin/env Rscript

# Example CPASSOC wrapper.
# Replace the function import below with the CPASSOC implementation used locally.

args <- commandArgs(trailingOnly=TRUE)
if (length(args) < 2) {
  stop("Usage: Rscript run_CPASSOC_TEMPLATE.R harmonized.txt output.txt")
}

dat <- read.table(args[1], header=TRUE, sep="\t", check.names=FALSE)

# Example vectors used by CPASSOC implementations:
Z <- cbind(dat$Z_CeD, dat$Z_HT)

# Insert the locally available CPASSOC function call here.
# Expected final output should include S_Hom / S_Het and corresponding P values.

write.table(
  dat,
  file=args[2],
  sep="\t",
  row.names=FALSE,
  quote=FALSE
)
