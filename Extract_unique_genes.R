library(readxl)
library(tidyverse)
library(writexl)
# read --------------------------------------------------------------------####
ruta_excel <- "AlesDEGDiciembre20.xlsx"
excel_sheets(ruta_excel)
# Females -----------------------------------------------------------------####
Females <- read_excel(ruta_excel,
                          sheet = "Females")%>%
  rename(unigenes_1 = ...1) %>%
  rename(unigenes_2 = ...9) %>%
  rename(unigenes_3 = ...17) %>%
  select(unigenes_1, unigenes_2, unigenes_3)

unigenes_1<-Females$unigenes_1
unigenes_2<-Females$unigenes_2
unigenes_3<-Females$unigenes_3
all_females<-as_tibble(c(unigenes_1, unigenes_2, unigenes_3)) %>%
  drop_na()

females_unique<-all_females %>%
  distinct() %>%
  rename(ID = value)

# Males -------------------------------------------------------------------####
Males <- read_excel(ruta_excel,
                      sheet = "Males")%>%
  rename(unigenes_1 = ...1) %>%
  rename(unigenes_2 = ...9) %>%
  rename(unigenes_3 = ...17) %>%
  select(unigenes_1, unigenes_2, unigenes_3)

unigenes_1<-Males$unigenes_1
unigenes_2<-Males$unigenes_2
unigenes_3<-Males$unigenes_3
all_males<-as_tibble(c(unigenes_1, unigenes_2, unigenes_3)) %>%
  drop_na()

males_unique<-all_males %>%
  distinct()
# Both -------------------------------------------------------------------####
both_genes_unique<-bind_rows(all_males, all_females) %>%
  distinct()
# Write ------------------------------------------------------------------####
write_xlsx(both_genes_unique, path ="Unique_male_femlales.xlsx")



