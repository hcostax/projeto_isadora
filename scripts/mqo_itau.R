

# |||||||||||||||||||||||||||||||||||||
# 
#   SCRIPT DE PROJETO PILOTO
#
#   Autor:        Henrique C. Costa
#   Site:         https://hcostax.com/
#
#--------------------------------------


suppressMessages(library("tidyverse"))

options(scipen = 9999)

# -----------------------------------------------
# CARREGAR A BASE DE DADOS JÁ EXISTENTE

# Restore the object
database <- readRDS(file = here::here("data",
                                      "database.rds")
)



# convert integer to date format
# https://stackoverflow.com/questions/52349973/how-to-convert-integer-to-date-format-in-r




dados <- database %>% 
  select(X.Nome_da_Administradora, CNPJ_da_Administradora,
         Data_base, Código_do_segmento, Taxa_de_administração,
         Quantidade_de_cotas_comercializadas_no_mês) %>% 
  mutate(
    Administradora  = X.Nome_da_Administradora,
    Codigo_adm      = CNPJ_da_Administradora,
    Data            = as.Date(paste(substr(Data_base, 1, 4), 
                                    substr(Data_base, 5, 6), "01", sep = "-")),
    Codigo_segmento = Código_do_segmento,
    Tax_adm         = Taxa_de_administração,
    Qtd_cotas       = as.numeric(Quantidade_de_cotas_comercializadas_no_mês)
  ) %>% 
  select(Administradora, Codigo_adm, Data, Codigo_segmento,
         Tax_adm, Qtd_cotas)



# ---------------------------------------------------------------


# FILTRAR ITAU

# ITAÚ ADM DE CONSÓRCIOS LTDA
# codigo: 776

# ITAÚ UNIBANCO VEÍCULOS ADM CONS LTDA.
# codigo: 42421776


itau_776 <- dados %>% 
  filter(
    Codigo_adm == "776")
    


itau_42421776 <- dados %>% 
  filter(
    Codigo_adm == "42421776")



# --------------------
# filtar por segmento 

itau.s1_776 <- itau_776 %>% 
  filter(Codigo_segmento == "1")


itau.s1_776[itau.s1_776==0] <- NA
itau.s1_776 <- itau.s1_776 %>% drop_na()



#-----------------------------------------
# analizando os dados


# carregar o tema customizado
source(here::here(
  "scripts", 
  "theme_custom.R")
)



suppressMessages(library(tidyverse))
suppressMessages(library(scales))

# pacote para inserir a logo
suppressMessages(library(magick))

#read logo
logo <- image_read(here::here( 
  "scripts",
  "logo-itau.png"))


suppressMessages(library(Cairo))

Cairo(file = here::here(
  
  "outputs",
  paste0("quantidade_cotas__", 
         format(
           Sys.time(), 
           "%d-%m-%Y"), 
         ".png")
), 
type="png",
units="in", 
width=8, 
height=5, 
pointsize=12*300/72, 
dpi=300)



itau.s1_776 %>% 
  ggplot(aes(x = Data, y = Qtd_cotas)) +
  geom_line(size=.8, colour='#f38223')+
  annotate("rect", fill = "gray50", alpha = 0.3, 
           xmin = as.Date('2020-02-26'), 
           xmax = as.Date(Sys.Date()),
           ymin = -Inf, ymax = Inf)+
  
  scale_x_date(breaks = date_breaks("1 year"),
               labels = date_format("%Y"))+
  labs(
    x = NULL,
    y = NULL,
    title = "Banco de dados de consórcios - BACEN",
    subtitle = "Quantidade de cotas comercializadas por mês \nSegmento 1: bens imóveis, para ITAÚ ADM DE CONSÓRCIOS LTDA",
    caption = " \nFonte: BACEN - Banco Central do Brasil, 2021 \nElaboração: https://hcostax.com "
  )  +
  theme_custom()


grid::grid.raster(
  logo, 
  x = 0.05, 
  y = 0.0099, 
  just = c('left', 'bottom'), 
  width = unit(0.5, 'inches')
)

# Closing the graphical device
dev.off() 

# --------------------------------------------------------

# carregar o tema customizado
source(here::here(
  "scripts", 
  "theme_custom.R")
)



suppressMessages(library(tidyverse))
suppressMessages(library(scales))

# pacote para inserir a logo
suppressMessages(library(magick))

#read logo
logo <- image_read(here::here( 
  "scripts",
  "logo-itau.png"))


suppressMessages(library(Cairo))

Cairo(file = here::here(
  
  "outputs",
  paste0("taxa_adm__", 
         format(
           Sys.time(), 
           "%d-%m-%Y"), 
         ".png")
), 
type="png",
units="in", 
width=8, 
height=5, 
pointsize=12*300/72, 
dpi=300)


itau.s1_776 %>% 
  ggplot(aes(x = Data, y = Tax_adm)) +
  geom_line(size=.8, colour='blue')+
  annotate("rect", fill = "gray50", alpha = 0.3, 
           xmin = as.Date('2020-02-26'), 
           xmax = as.Date(Sys.Date()),
           ymin = -Inf, ymax = Inf)+
  
  scale_x_date(breaks = date_breaks("1 year"),
               labels = date_format("%Y"))+
  labs(
    x = NULL,
    y = NULL,
    title = "Banco de dados de consórcios - BACEN",
    subtitle = "Taxa de administração praticadas por mês \nSegmento 1: bens imóveis, para ITAÚ ADM DE CONSÓRCIOS LTDA",
    caption = " \nFonte: BACEN - Banco Central do Brasil, 2021 \nElaboração: https://hcostax.com "
  )  +
  theme_custom()

grid::grid.raster(
  logo, 
  x = 0.05, 
  y = 0.0099, 
  just = c('left', 'bottom'), 
  width = unit(0.5, 'inches')
)

# Closing the graphical device
dev.off() 

# ----------------------------------------------------


# carregar o tema customizado
source(here::here(
  "scripts", 
  "theme_custom.R")
)



suppressMessages(library(tidyverse))
suppressMessages(library(scales))

# pacote para inserir a logo
suppressMessages(library(magick))

#read logo
logo <- image_read(here::here( 
  "scripts",
  "logo-itau.png"))


suppressMessages(library(Cairo))

Cairo(file = here::here(
  
  "outputs",
  paste0("dispersao_lm__", 
         format(
           Sys.time(), 
           "%d-%m-%Y"), 
         ".png")
), 
type="png",
units="in", 
width=8, 
height=5, 
pointsize=12*300/72, 
dpi=300)


# itau.s1_776 %>% 
#   ggplot(aes(x = Tax_adm, y = Qtd_cotas)) +
#   geom_point(color = "orange", size = 2)


itau.s1_776 %>% 
  ggplot(aes(x = Tax_adm, y = Qtd_cotas)) +
  geom_point(color = "orange", size = 2) +
  geom_smooth(method = lm, se = TRUE) +
  # annotate("rect", fill = "gray50", alpha = 0.3, 
  #          xmin = , 
  #          xmax = as.Date(Sys.Date()),
  #          ymin = -Inf, ymax = Inf)+
  # 
  # scale_x_date(breaks = date_breaks("1 year"),
  #              labels = date_format("%Y"))+
  labs(
    x = "Taxa de Administração",
    y = "Quantidade de Cotas comercializadas por mês",
    title = "Banco de dados de consórcios - BACEN",
    subtitle = "Dispersão e reta de regressão (relação entre X e Y) \nSegmento 1: bens imóveis, para ITAÚ ADM DE CONSÓRCIOS LTDA",
    caption = " \nFonte: BACEN - Banco Central do Brasil, 2021 \nElaboração: https://hcostax.com "
  )  +
  theme_custom()


grid::grid.raster(
  logo, 
  x = 0.05, 
  y = 0.0099, 
  just = c('left', 'bottom'), 
  width = unit(0.5, 'inches')
)

# Closing the graphical device
dev.off() 

#-----------------------------------------------

# ----- 
# MODELOS

modelo_1 <- lm(Qtd_cotas ~ Tax_adm, data = itau.s1_776)
summary(modelo_1)

modelo_2 <- lm(Qtd_cotas ~ log(Tax_adm), data = itau.s1_776)
summary(modelo_2)

modelo_3 <- lm(log(Qtd_cotas) ~ log(Tax_adm), data = itau.s1_776)
summary(modelo_3)




modelo_4 <- lm(Qtd_cotas ~ 0 + Tax_adm, data = itau.s1_776)
summary(modelo_4)

modelo_5 <- lm(Qtd_cotas ~ 0 + log(Tax_adm), data = itau.s1_776)
summary(modelo_5)


modelo_6 <- lm(log(Qtd_cotas) ~ 0 + log(Tax_adm), data = itau.s1_776)
summary(modelo_6)




# ----
modelo_7 <- lm(log(Tax_adm) ~ 0 + log(Qtd_cotas), data = itau.s1_776)
summary(modelo_7)
# ----

# https://uvastatlab.github.io/phdplus/modelviz.html

suppressMessages(library(stargazer))

stargazer(modelo_6, type = "html")



# ---------------------------

itau.s1_776 %>% 
  ggplot(aes(x = Qtd_cotas)) +
  geom_histogram(alpha = 0.45,
                 fill = "cornflowerblue")




itau.s1_776 %>% 
  ggplot(aes(x = Tax_adm)) +
  geom_histogram(alpha = 0.45,
                 fill = "cornflowerblue")





# Teste de Shapiro-Wilk para normalidade
shapiro.test(modelo_4$residuals)
# Teste de Shapiro-Wilk para normalidade
shapiro.test(modelo_5$residuals)
# Teste de Shapiro-Wilk para normalidade
shapiro.test(modelo_6$residuals)




# Análise de Resíduos 
par(mfrow = c(2,2))

plot(modelo_4, which = c(1:4), pch = 20)
plot(modelo_5, which = c(1:4), pch = 20)
plot(modelo_6, which = c(1:4), pch = 20)



# correlacao
cor(itau.s1_776[,5:6])













