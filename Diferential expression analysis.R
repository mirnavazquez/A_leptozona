if (!requireNamespace("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager")

BiocManager::install(c("readr","tximport","DESeq2", "vsn",
                       "pheatmap", "apeglm","genefilter"))