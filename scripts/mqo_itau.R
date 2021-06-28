

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


# analizando os dados

itau.s1_776 %>% 
  ggplot(aes(x = Data)) +
  geom_line(aes(y = Qtd_cotas), color = "blue", size = 1) 

itau.s1_776 %>% 
  ggplot(aes(x = Data)) +
  geom_line(aes(y = Tax_adm), color = "green", size = 1)



itau.s1_776 %>% 
  ggplot(aes(x = Tax_adm, y = Qtd_cotas)) +
  geom_point(color = "orange", size = 2)


itau.s1_776 %>% 
  ggplot(aes(x = Tax_adm, y = Qtd_cotas)) +
  geom_point(color = "orange", size = 2) +
  geom_smooth(method = lm, se = TRUE)



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













