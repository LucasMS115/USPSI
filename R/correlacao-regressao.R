inclinacao <- function(x, y){
  
  b <- 0
  n <- length(x)
  xm <- mean(x)
  ym <- mean(y)
  vx <- var(x)
  
  #somatorio
  for(i in 1:n){
    b <- b +((x[i]-xm)*(y[i]-ym))
  }
  
  b <- b/((n-1)*vx)
  
  return(b)
}

intercepto <- function(xm, ym, b){
  return(ym - b*xm)
}

peso = c(12, 13, 14, 14, 16, 18, 19, 22, 24, 26)
rendimento = c(16, 14, 14, 13, 11, 12, 09, 09, 08, 06)

df1 <- data.frame( peso = peso, rendimento = rendimento)

#medias
xm <- mean(peso)
ym <- mean(rendimento)

#variancia
xv <- var(peso)

#coeficiente de pearson
r <- cor(peso, rendimento)

#coeficintes de regressao
b <- inclinacao(peso, rendimento)
a <- intercepto(xm,ym,b)

#equacao da reta => Y = a + bX

#regressao(lista)
regressao <- lm(rendimento~peso, data = df1)

summary(regressao)

#grafico de regressao
g = plot(peso, rendimento) #bolinhas
grid(g) #aplicando grid ao gráfico
abline(regressao) #linha da regressao
