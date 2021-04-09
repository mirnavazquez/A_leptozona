# Instalar librerias  -----------------------------------------------------####
if (!requireNamespace("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager")

BiocManager::install(c("readr","tximport","DESeq2", "vsn",
                       "pheatmap", "apeglm","genefilter"))
# Llamar a las librerias --------------------------------------------------####
library(tximport)
library(DESeq2)
library(tidyverse)
# Importar datos ----------------------------------------------------------####
list.files("BGen_Results-20210409T213500Z-001/BGen_Results/")
did <- getwd()
Ruta <- "C:/Users/GAIA/Documents/RstudioTesis/A_leptozona/BGen_Results-20210409T213500Z-001/BGen_Results/"
samples <- list.files("BGen_Results-20210409T213500Z-001/BGen_Results/")
files <- file.path(Ruta, samples)
names(files) <-gsub(".genes.results","", samples, perl = T)
txi <- tximport(files, type = "rsem")
names(txi)
head(txi$counts)
#save(txi, file="tximport.RData")
# Crear samples described -------------------------------------------------####
samples<-as_tibble(samples)
samples$dias <- c("", "")
samples$color <- c("", "")
samples$sexo<- c("", "")
# Leer el archivo txi -----------------------------------------------------####
load("tximport.RData")
# Transformar -------------------------------------------------------------####
###Transformar los 0 en 1, siguiendo: https://support.bioconductor.org/p/92763/
which(txi$length == 0)
zero <- which(txi$length == 0)
txi$length[zero] <- 1
which(txi$length == 0)
# Core analysis -----------------------------------------------------------####
dds <- DESeqDataSetFromTximport(txi, samples, ~1)
colData(dds)













