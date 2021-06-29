
# |||||||||||||||||||||||||||||||||||||
# 
#   SCRIPT DE PROJETO PILOTO
#
#   Autor:        Henrique C. Costa
#   Site:         https://hcostax.com/
#
#--------------------------------------




# ------------------------------------------------
# ADICIONAR ATUALIZACAO E SAVAR NOVA BASE DE DADOS

# usar o o seguinte formato para a data atualizada:
# "ANO-MES-DIA"
data_atualizada <- "2021-04-01"


# ou usar esse comando que calcula a diferenca entre
# o dia de hoje e o mes da ultima atualizacao do BACEN
# data_atualizada <- Sys.Date() - 60


# rodar o script para atualizar
source(here::here("scripts", "atualizar_bd.R"))

# ----------------------------------------------
# rodar o modelo log-log com os resultados
# rmarkdown::render(here::here("outputs", "report_mqo_itau.Rmd"), 
#                   'html_document')

# abrir a analise
browseURL(here::here("outputs", "report_mqo_itau.html"))


#-----------------------------------------------




