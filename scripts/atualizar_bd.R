
# |||||||||||||||||||||||||||||||||||||
# 
#   SCRIPT DE PROJETO PILOTO
#
#   Autor:        Henrique C. Costa
#   Site:         https://hcostax.com/
#
#--------------------------------------


suppressMessages(library(lubridate))
suppressMessages(library("pdftools"))
suppressMessages(library("glue"))
suppressMessages(library("tidyverse"))


# -----------------------------------------------
# CARREGAR A BASE DE DADOS JÁ EXISTENTE

# Restore the object
database <- readRDS(file = here::here("data",
                          "database.rds")
        )



# ------------------------------------------------
# ADICIONAR ATUALIZACAO E SAVAR NOVA BASE DE DADOS

# usar o o seguinte formato para a data atualizada:
# "ANO-MES-DIA"
# data_atualizada <- "2021-04-01"

# configurar o local pra salvar o novo arquivo
setwd(here::here("data", "raw_data"))

data_updated <- format(as.Date(data_atualizada), format="%Y%m")


# Creates a String of the URL Addresses
urls <- 
  tidyr::expand_grid(data_updated) %>%
  glue_data("https://www.bcb.gov.br/Fis/Consorcios/Port/BD/{data_updated}Consorcios.zip")


# Creates Names for the PDF Files 
zipfiles_names <- 
  tidyr::expand_grid(data_updated) %>%
  glue_data("bacen-consorcio-{data_updated}.zip")

safe_download <- safely(~ download.file(.x , .y, mode = "wb"))

walk2(urls, zipfiles_names , safe_download)



# ------------------------------------------------------------
# CARREGAR A NOVA BASE DE DADOS

suppressMessages(library(plyr))


# unzip all your files
ldply(
  .data = paste0(here::here("data", 
                            "raw_data"),"/", 
                 zipfiles_names), 
  .fun = unzip, 
  exdir = here::here("data", 
                     "raw_data",
                     "unziped"))



# https://theautomatic.net/2018/07/11/manipulate-files-r/
# With unlink, we can delete the selected files 
# we created above with file.create — also 
# in just one line of code.
sapply(paste0(here::here("data", 
                         "raw_data",
                         "unziped"),"/", 
              data_updated, 
              "Bens_Imoveis_Grupos", ".csv"), unlink)

sapply(paste0(here::here("data", 
                         "raw_data",
                         "unziped"),"/", 
              data_updated, 
              "Bens_Moveis_Grupos", ".csv"), unlink)

sapply(paste0(here::here("data", 
                         "raw_data",
                         "unziped"),"/", 
              "Significado_dos_campos_e_metricas", ".xlsx"), unlink)




# read the csv files
new_data <- ldply(.data = paste0(here::here("data", 
                                           "raw_data",
                                           "unziped"),"/", 
                                 data_updated,"Segmentos_Consolidados.csv"), 
                 .fun = read.csv2)

new_database <- rbind(database, 
                      new_data)



# -----------------------------------------------
# http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

# SAVE 

# Save an object to a file
saveRDS(new_database, 
        file = here::here("data",
                          "database.rds")
)

# # Restore the object
# database <- readRDS(file = here::here("data", 
#                           "database.rds")
#         )


# -----------------------------------------------
# salvando os dados em uma tabela de excel
suppressMessages(library(writexl))

# salvar a taxa de cambio diaria
write_xlsx(
  new_database,
  here::here(
    "outputs",
    
    # renomear com a data da ultima atualizacao
    paste0("database__", 
           format(
             Sys.time(), "%d-%m-%Y"), ".xlsx"))
)

# ------------------------------------------------


# limpar o environment
rm(list = ls())

# filtrar itau

# ITAÚ ADM DE CONSÓRCIOS LTDA
# codigo: 776

# ITAÚ UNIBANCO VEÍCULOS ADM CONS LTDA.
# codigo: 42421776





