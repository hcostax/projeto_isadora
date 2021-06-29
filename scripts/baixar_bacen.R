
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


setwd(here::here("data", "raw_data"))


date <- seq(as.Date("2010-01-01"), 
            as.Date("2021-03-01"), 
            by = "month")

date <- format(date, format="%Y%m")


# Creates a String of the URL Addresses
urls <- 
  tidyr::expand_grid(date) %>%
  glue_data("https://www.bcb.gov.br/Fis/Consorcios/Port/BD/{date}Consorcios.zip")

# Creates Names for the PDF Files 
zipfiles_names <- 
  tidyr::expand_grid(date) %>%
  glue_data("bacen-consorcio-{date}.zip")

safe_download <- safely(~ download.file(.x , .y, mode = "wb"))
walk2(urls, zipfiles_names , safe_download)


