# Instalar librerias  -----------------------------------------------------####
if (!requireNamespace("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager")

BiocManager::install(c("readr","tximport","DESeq2", "vsn",
                       "pheatmap", "apeglm","genefilter"))
# Llamar a las librerias --------------------------------------------------####
library(tximport)
library(DESeq2)
library(tidyverse)
library(readxl)
library(janitor)
library(ggplot2)
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
samples<-read_excel("CuadroSuplementario1_Resultasdos -MVRL.xlsx", 
                    sheet = "Sheet1") %>%
  clean_names() %>%
  select(-c(secuncias_crudas, x5)) %>%
  filter(x4 != "Librerías") %>%
  fill(sexo) %>%
  fill(dias) %>%
  mutate(dias = str_replace(dias, " \\(.*", "")) %>%
  mutate(color = case_when(
    dias == "02-03" ~ "No_color",
    dias == "03-05" ~ "Transicion_a_verde",
    dias == "10-12" ~ "Coloracion_verdosa"
  )) %>%
  mutate(x4 = str_replace(x4, "$", ".genes.results")) %>%
  rename(Name = x4) %>%
  select(color, dias, sexo, Name) %>%
  mutate(dias = str_replace(dias, "-", "_"))

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
keep = rowSums(counts(dds)) >= 10
dds = dds[keep, ]

#dds$color <- relevel(dds$color,"No_color")
dds$group <- factor(paste0(dds$color, dds$dias, dds$sexo))
design(dds) <- ~ group
#dds <- DESeq(dds)
#save(dds, file="dds.RData")
load("dds.RData")
plotDispEsts(dds)

vsd <- vst(dds, blind=FALSE)
pcaData <- plotPCA(vsd, intgroup=c("color", "dias", "sexo"), returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=color, shape=sexo)) +
  geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed()












