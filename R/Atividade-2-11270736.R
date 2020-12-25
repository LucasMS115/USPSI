### Lucas Mendes Sales - 11270736 ###

setwd("C:/Users/adm/Documents/MATERIAS/Semestre-4/MQA")

# Importar base de dados (criar data frame)
library(readxl) 
df <- read_excel("Pesquisa++em+Florianopolis.xlsx") # carregar de xls ou xlsx 
summary(df$tamanho) 
tam <- df$tamanho

# Centrais
media_tam <- mean(tam)
mediana_tam <- median(tam)

factor_tam <- as.factor(tam) 
summary(factor_tam)

# Dispersao
var_tam <- var(tam) #variancia
desvio <- sqrt(var_tam)
cv <- desvio/media_tam

# Variaveis de renda separadas pelo local
df$local <- as.factor(df$local)
r1 <- as.double(df$renda[df$local == 1])
r2 <- as.double(df$renda[df$local == 2])
r3 <- as.double(df$renda[df$local == 3])

summary(r1)
summary(r2)
summary(r3)

# Retornar limites em um vetor [superior, inferior]
limites <- function(qrts){
  ls <- qrts[4] + 1.5*(qrts[4] - qrts[2])
  li <- qrts[2] - 1.5*(qrts[4] - qrts[2])
  return (c(ls,li))
}

# Quartis
qr1 <- quantile(r1)
qr2 <- quantile(r2)
qr3 <- quantile(r3)

# Limites
l1 <- limites(qr1)
l2 <- limites(qr2)
l3 <- limites(qr3)

# outliers
out_1 <- r1[r1 > l1[1] | r1 < l1[2]]
out_2 <- r2[r2> l2[1] | r2 < l2[2]]
out_1 <- r3[r3 > l3[1] | r3 < l3[2]]

#boxplot(r1, r2, r3)
