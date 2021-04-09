if (!requireNamespace("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager")

BiocManager::install(c("readr","tximport","DESeq2", "vsn",
                       "pheatmap", "apeglm","genefilter"))
library(tximport)
list.files("BGen_Results-20210409T213500Z-001/BGen_Results/")
did <- getwd()
Ruta <- "C:/Users/GAIA/Documents/RstudioTesis/A_leptozona/BGen_Results-20210409T213500Z-001/BGen_Results/"
samples <- list.files("BGen_Results-20210409T213500Z-001/BGen_Results/")

files <- file.path(Ruta, samples)

names(files) <-gsub(".genes.results","", samples, perl = T)

txi <- tximport(files, type = "rsem")
names(txi)
head(txi$counts)
save(txi, file="tximport.RData")
