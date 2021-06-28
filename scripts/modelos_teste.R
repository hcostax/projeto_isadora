

library(readr)
X202104Segmentos_Consolidados <- read_delim("C:/Users/user/Desktop/202104Segmentos_Consolidados.csv", 
                                            ";", escape_double = FALSE, trim_ws = TRUE)
View(X202104Segmentos_Consolidados)



dados <- X202104Segmentos_Consolidados


dados <- dados %>% 
  select(cd_seg, taxa_adm, qcotas) %>% 
  mutate(taxa_adm = as.numeric(taxa_adm))


seg_1 <- dados %>% 
  filter(cd_seg == "1")


modelo_1 <- lm(qcotas ~ taxa_adm, data = seg_1)

summary(modelo_1)

##Go through each row and determine if a value is zero
row_sub = apply(seg_1, 1, function(row) all(row !=0 ))
##Subset as usual
seg_1 <- seg_1[row_sub,]

seg_1log <- seg_1 %>% mutate(taxa_adm = log(taxa_adm))
modelo_2 <- lm(qcotas ~ taxa_adm, data = seg_1log)

summary(modelo_2)



modelo_3 <- lm(log(qcotas) ~ log(taxa_adm), data = seg_1)

summary(modelo_3)



modelo_4 <- lm(qcotas ~ 0 + log(taxa_adm), data = seg_1)

summary(modelo_4)


modelo_5 <- lm(log(qcotas) ~ 0 + log(taxa_adm), data = seg_1)

summary(modelo_5)

seg_1 %>% 
  ggplot(aes(y=qcotas, x=taxa_adm)) +
  geom_point()




seg_1 %>% 
  ggplot(aes(y=qcotas, x=taxa_adm)) +
  geom_point() + geom_smooth(method = lm, se=TRUE)



seg_1 %>% 
  ggplot(aes(x = qcotas)) +
  geom_histogram(alpha = 0.45,
                 
                 fill = "cornflowerblue")


seg_1 %>% 
  ggplot(aes(x = taxa_adm)) +
  geom_histogram(alpha = 0.45,
                 # binwidth = .01,
                 fill = "cornflowerblue")


# Análise de Resíduos 
par(mfrow = c(2,2))
plot(modelo_5, which = c(1:4), pch = 20)


# Teste de Shapiro-Wilk para normalidade
shapiro.test(modelo_5$residuals)
