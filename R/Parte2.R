#Definir diretorio
setwd("C:/Users/adm/Documents/MATERIAS/Semestre-4/MQA/Trabalho/vgs")

#Libs
if(!require(readxl)) install.packages("readxl")
library(readxl)

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

if(!require(xlsx)) install.packages("xlsx")
library("xlsx")

if(!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

if(!require(Metrics)) install.packages("Metrics")
library(Metrics)

#Importacao do dataset
df <- read_excel("vgs.xlsx")

#Ver os tipos dos dados
#glimpse(df)

#Mudando o tipo de algumas colunas para fator
df$Rank <- as.factor(df$Rank)
df$Year <- as.integer(df$Year)
df$NA_Sales <- as.double(df$NA_Sales)
df$EU_Sales <- as.double(df$EU_Sales)
df$JP_Sales <- as.double(df$JP_Sales)
df$Other_Sales <- as.double(df$Other_Sales)
df$Global_Sales <- as.double(df$Global_Sales)


### Filtrando linhas
df <- df %>% na.omit
df <- df[df$Year >= 2008 & df$Year <= 2011,]


### Calculo de moda
moda <- function(x) {
  ux <- unique(x)
  return(ux[which.max(tabulate(match(x, ux)))])
}


### Criar tabela de frequencia 
frequencia = function(dados, categoria, intervalo){
  
  dados <- dados %>% na.omit
  
  if(intervalo){
    r <- range(dados)
    n <- nclass.Sturges(dados)
    dados <- cut(dados, seq(0, r[2], l = n+1))
  }
  
  dados.plot <- data.frame(table(dados), table(dados)/sum(table(dados)),
                           cumsum(prop.table(table(dados))))
  
  dados.plot <- dados.plot[, -3]
  
  names(dados.plot) <- c(categoria ,"Absoluta", "Relativa", "Acumulada")
  
  
  dados.plot$Relativa <- as.double(dados.plot$Relativa)
  n <- nrow(dados.plot)
  
  for(i in 1:n){
    x <- as.double(dados.plot$Relativa[i])
    y <- as.double(dados.plot$Acumulada[i])
    dados.plot$Relativa[i] <- format(round(x, 5), nsmall = 5)
    dados.plot$Acumulada[i] <- format(round(y, 5), nsmall = 5)
  }
  
  return(dados.plot)
  
}


### criar matriz com medidas de posicao e dispercao
posDisp = function(dados){
  
  dados <- dados %>% na.omit
  
  media <- mean(dados)
  mediana <- median(dados)
  moda <- moda(dados)
  q1 <-quantile(dados)[2]
  q3 <-quantile(dados)[4]
  variancia <- var(dados)
  dp <- sqrt(variancia)
  cv <- dp/media
  
  m <- matrix(NA, nrow = 8, ncol = 2, dimnames = list(c("Media", "Mediana","Moda","Q1","Q3","Var","DP","CV"), 
                                                      c("valores", "-")))
  for(i in 1:8){
    m[i,2] <- " - "
  }
  
  m[1,1] <- format(round(media, 3), nsmall = 3)
  m[2,1] <- mediana
  m[3,1] <- moda
  m[4,1] <- q1
  m[5,1] <- q3
  m[6,1] <- format(round(variancia, 3), nsmall = 3)
  m[7,1] <- format(round(dp, 3), nsmall = 3)
  m[8,1] <- format(round(cv, 3), nsmall = 3)
  
  return(m);
  
}

### Distancia/erro/residuo
distancia = function (a, b){
  d = sqrt((a-b)^2);
  return(d);
}

distSet = function (a, b){
  l = length(a);
  
  if(l != length(b)){
    print("tamanhos diferentes")
    return();
  };
  
  i <- 0
  mt <- matrix(NA, nrow = l, ncol = 1);
  while (i < l) {
    i = i+1;
    print(i);
    mt[i,1] = distancia(a[i], b[i]);
  }
  return(mt);
}



### Rodar os modelos

testaModelo = function (mod){
  l = length(df$Global_Sales);
  i <- 0
  mt <- matrix(NA, nrow = l, ncol = 1);
  while (i < l) {
    i = i+1;
    mt[i,1] = predict(mod, data.frame(
      NA_Sales = df$NA_Sales[i], EU_Sales = df$EU_Sales[i], JP_Sales = df$JP_Sales[i], Other_Sales = df$Other_Sales[i]));
  }
  return(mt);
}

toDummy = function(values, rightValue){
  l = length(values);
  i <- 0
  mt <- matrix(NA, nrow = l, ncol = 1);
  while (i < l) {
    i <- i+1;
    if(values[i] == rightValue){
      print("1");
      mt[i,1] <- 1;
    } 
    else{
      mt[i,1] <- 0;
    } 
  }
  return(mt);
}


toDummyPlat = function(values){
  l = length(values);
  i <- 0
  mt <- matrix(NA, nrow = l, ncol = 1);
  while (i < l) {
    i <- i+1;
    if(values[i] == "PC" || values[i] == "PS3" || values[i] == "wii" || values[i] == "X360"){
      print("1");
      mt[i,1] <- 1;
    } 
    else{
      mt[i,1] <- 0;
    } 
  }
  return(mt);
}



# Retornar limites em um vetor [superior, inferior]
limites = function(qrts){
  ls <- qrts[4] + 1.5*(qrts[4] - qrts[2])
  li <- qrts[2] - 1.5*(qrts[4] - qrts[2])
  return (c(ls,li))
}

################ Testes de regressão ################ 

correlacaoVendas <- cor(df[7:11]) # Matriz de correlação

# NA x Global
mod_NA_G <- lm(Global_Sales~NA_Sales, data = df)

#grafico de regressao
#g = plot(df$NA_Sales, df$Global_Sales) #bolinhas
#grid(g) #aplicando grid ao gráfico
#abline(mod_NA_G) #linha da regressao

# /NA x Global

#-------------------------------------------------------------------------------------------------------------------

# EU x Global
mod_EU_G <- lm(Global_Sales~EU_Sales, data = df)

#grafico de regressao
#g = plot(df$EU_Sales, df$Global_Sales) #bolinhas
#grid(g) #aplicando grid ao gráfico
#abline(mod_EU_G) #linha da regressao

# /EU x Global

#-------------------------------------------------------------------------------------------------------------------

# JP x Global
mod_JP_G <- lm(Global_Sales~JP_Sales, data = df)

#grafico de regressao
#g = plot(df$JP_Sales, df$Global_Sales) #bolinhas
#grid(g) #aplicando grid ao gráfico
#abline(mod_JP_G) #linha da regressao

# /JP x Global

#-------------------------------------------------------------------------------------------------------------------

# Other x Global
mod_Other_G <- lm(Global_Sales~Other_Sales, data = df)

#grafico de regressao
#g = plot(df$Other_Sales, df$Global_Sales) #bolinhas
#grid(g) #aplicando grid ao gráfico
#abline(mod_Other_G) #linha da regressao

# /Other x Global

#-------------------------------------------------------------------------------------------------------------------

# NA,EU x Global

mod_NA_EU_G <- lm(Global_Sales~NA_Sales + EU_Sales + NA_Sales:EU_Sales, data = df)

#predict(mod_NA_EU_G, data.frame(NA_Sales = df$NA_Sales[1], EU_Sales = df$EU_Sales[1]))

# /NA,EU x Global

#-------------------------------------------------------------------------------------------------------------------

# NA,JP x Global

mod_NA_JP_G <- lm(Global_Sales~NA_Sales + JP_Sales + NA_Sales:JP_Sales, data = df)

#predict(mod_NA_JP_G, data.frame(NA_Sales = 15.85, JP_Sales = 3.79))

# /NA,JP x Global

#-------------------------------------------------------------------------------------------------------------------

# NA,Others x Global

mod_NA_Other_G <- lm(Global_Sales~NA_Sales + Other_Sales + NA_Sales:Other_Sales, data = df)

#predict(mod_NA_Other_G, data.frame(NA_Sales = 15.85, Other_Sales = 3.31))

# /NA,Others x Global

#-------------------------------------------------------------------------------------------------------------------

# EU,JP x Global

mod_EU_JP_G <- lm(Global_Sales~EU_Sales + JP_Sales + EU_Sales:JP_Sales, data = df)

#predict(mod_EU_JP_G, data.frame(EU_Sales = 12.88, JP_Sales = 3.79))

# /EU,JP x Global

#-------------------------------------------------------------------------------------------------------------------

# EU,Other x Global

mod_EU_Other_G <- lm(Global_Sales~EU_Sales + Other_Sales + EU_Sales:Other_Sales, data = df)

#predict(mod_EU_Other_G, data.frame(EU_Sales = 12.88, Other_Sales = 3.31))

# /EU,Other x Global

#-------------------------------------------------------------------------------------------------------------------

# JP,Other x Global

mod_JP_Other_G <- lm(Global_Sales~JP_Sales + Other_Sales + JP_Sales:Other_Sales, data = df)

#predict(mod_JP_Other_G, data.frame(JP_Sales = 3.79, Other_Sales = 3.31))

# /JP,Other x Global

#-------------------------------------------------------------------------------------------------------------------

# NA,EU,JP x Global

mod_NA_EU_JP_G <- lm(Global_Sales~ NA_Sales + EU_Sales + JP_Sales + NA_Sales:EU_Sales:JP_Sales, data = df)

#predict(mod_NA_EU_JP_G, data.frame(NA_Sales = 15.85 ,EU_Sales = 12.88, JP_Sales = 3.79))

# /NA,EU,JP x Global

#-------------------------------------------------------------------------------------------------------------------

# NA,EU,Other x Global

mod_NA_EU_Other_G <- lm(Global_Sales~ NA_Sales + EU_Sales + Other_Sales + NA_Sales:EU_Sales:Other_Sales, data = df)

#predict(mod_NA_EU_Other_G, data.frame(NA_Sales = 15.85 ,EU_Sales = 12.88, Other_Sales = 3.31))

# /NA,EU,Other x Global

#-------------------------------------------------------------------------------------------------------------------

# NA,JP,Other x Global

mod_NA_JP_Other_G <- lm(Global_Sales~ NA_Sales + JP_Sales + Other_Sales + NA_Sales:JP_Sales:Other_Sales, data = df)

#predict(mod_NA_JP_Other_G, data.frame(NA_Sales = 15.85 ,JP_Sales = 3.79, Other_Sales = 3.31))

# /NA,JP,Other x Global

#-------------------------------------------------------------------------------------------------------------------

# EU,JP,Other x Global

mod_EU_JP_Other_G <- lm(Global_Sales~ EU_Sales + JP_Sales + Other_Sales + EU_Sales:JP_Sales:Other_Sales, data = df)

#predict(mod_EU_JP_Other_G, data.frame(EU_Sales = 12.88 ,JP_Sales = 3.79, Other_Sales = 3.31))

# /EU,JP,Other x Global

# Testando os modelos
res_NA_G <- testaModelo(mod_NA_G);
res_EU_G <- testaModelo(mod_EU_G);
res_JP_G <- testaModelo(mod_JP_G);
res_Other_G <- testaModelo(mod_Other_G);
res_NA_EU_G <- testaModelo(mod_NA_EU_G);
res_NA_JP_G <- testaModelo(mod_NA_JP_G);
res_NA_Other_G <- testaModelo(mod_NA_Other_G);
res_EU_JP_G <- testaModelo(mod_EU_JP_G);
res_EU_Other_G <- testaModelo(mod_EU_Other_G);
res_JP_Other_G <- testaModelo(mod_JP_Other_G);
res_NA_EU_JP_G <- testaModelo(mod_NA_EU_JP_G);
res_NA_EU_Other_G <- testaModelo(mod_NA_EU_Other_G);
res_NA_JP_Other_G <- testaModelo(mod_NA_JP_Other_G);
res_EU_JP_Other_G <- testaModelo(mod_EU_JP_Other_G);

#guardando os resultados em dfRes
dfRes <- data.frame(
  res_NA_G, res_EU_G, res_JP_G, res_Other_G, res_NA_EU_G, res_NA_JP_G,
  res_NA_Other_G, res_EU_JP_G, res_EU_Other_G,res_JP_Other_G, res_NA_EU_JP_G, res_NA_EU_Other_G,
  res_NA_JP_Other_G, res_EU_JP_Other_G,
  df$Global_Sales);

# distancias

dist_NA <- distSet(dfRes$res_NA_G, dfRes$df.Global_Sales);
dist_EU <- distSet(dfRes$res_EU_G, dfRes$df.Global_Sales);
dist_JP <- distSet(dfRes$res_JP_G, dfRes$df.Global_Sales);
dist_Other <- distSet(dfRes$res_Other_G, dfRes$df.Global_Sales);
dist_NA_EU <- distSet(dfRes$res_NA_EU_G, dfRes$df.Global_Sales);
dist_NA_JP <- distSet(dfRes$res_NA_JP_G, dfRes$df.Global_Sales);
dist_NA_Other <- distSet(dfRes$res_NA_Other_G, dfRes$df.Global_Sales);
dist_EU_JP <- distSet(dfRes$res_EU_JP_G, dfRes$df.Global_Sales);
dist_EU_Other <- distSet(dfRes$res_EU_Other_G, dfRes$df.Global_Sales);
dist_JP_Other <- distSet(dfRes$res_JP_Other_G, dfRes$df.Global_Sales);
dist_NA_EU_JP <- distSet(dfRes$res_NA_EU_JP_G, dfRes$df.Global_Sales);
dist_NA_EU_Other <- distSet(dfRes$res_NA_EU_Other_G, dfRes$df.Global_Sales);
dist_NA_JP_Other <- distSet(dfRes$res_NA_JP_Other_G, dfRes$df.Global_Sales);
dist_EU_JP_Other <- distSet(dfRes$res_EU_JP_Other_G, dfRes$df.Global_Sales);

dfDist <- data.frame(dist_NA, dist_EU, dist_JP, dist_Other, dist_NA_EU, dist_NA_JP, dist_NA_Other,
                     dist_EU_JP, dist_EU_Other, dist_JP_Other, dist_NA_EU_JP, dist_NA_EU_Other,
                     dist_NA_JP_Other, dist_EU_JP_Other);

distMeans <- c(mean(dist_NA), mean(dist_EU), mean(dist_JP), mean(dist_Other), mean(dist_NA_EU), mean(dist_NA_JP), mean(dist_NA_Other),
               mean(dist_EU_JP), mean(dist_EU_Other), mean(dist_JP_Other), mean(dist_NA_EU_JP), mean(dist_NA_EU_Other),
               mean(dist_NA_JP_Other), mean(dist_EU_JP_Other));


#plataforms <- c("3DS", "DC", "DS", "PC", "PS2", "PS3", "PSP", "PSV", "Wii", "X360", "XB"); # 11 

#genres <- c("Action", "Adventure", "Fighting", "Misc", "Plataform", "Puzzle", "Racing", "Role Playing",
            #"Shooter", "Simulation", "Sports"); 

DS3 <- toDummy(df$Platform, "3DS")
DC <- toDummy(df$Platform, "DC")
DS <- toDummy(df$Platform, "DS")
PC <- toDummy(df$Platform, "PC")
PS2 <- toDummy(df$Platform, "PS2")
PS3 <- toDummy(df$Platform, "PS3")
PSP <- toDummy(df$Platform, "PSP")
PSV <- toDummy(df$Platform, "PSV")
Wii <- toDummy(df$Platform, "Wii")
X360 <- toDummy(df$Platform, "X360")
XB <- toDummy(df$Platform, "XB")

dfDummies <- df[,-3]
dfDummies <- dfDummies[,-4]

dfDummies$DS3 <- DS3
dfDummies$DC <- DC
dfDummies$DS <- DS 
dfDummies$PC <- PC
dfDummies$PS2 <- PS2 
dfDummies$PS3 <- PS3 
dfDummies$PSP <- PSP
dfDummies$PSV <- PSV 
dfDummies$Wii <- Wii 
dfDummies$X360 <- X360 

Action <- toDummy(df$Genre, "Action")
Adventure <- toDummy(df$Genre, "Adventure")
Fighting <- toDummy(df$Genre, "Fighting")
Misc <- toDummy(df$Genre, "Misc")
Platform <- toDummy(df$Genre, "Platform")
Puzzle <- toDummy(df$Genre, "Puzzle")
Racing <- toDummy(df$Genre, "Racing")
RPG <- toDummy(df$Genre, "Role-Playing")
Shooter <- toDummy(df$Genre, "Shooter")
Simulation <- toDummy(df$Genre, "Simulation")
Sports <- toDummy(df$Genre, "Sports")
Strategy <- toDummy(df$Genre, "Strategy")


dfDummiesGen <-  df[,-5]

dfDummiesGen$Action <- Action
dfDummiesGen$Adventure <- Adventure
dfDummiesGen$Fighting <- Fighting 
dfDummiesGen$Misc <- Misc
dfDummiesGen$Platform <- Platform 
dfDummiesGen$Puzzle <- Puzzle 
dfDummiesGen$Racing <- Racing
dfDummiesGen$RPG <- RPG 
dfDummiesGen$Shooter <- Shooter 
dfDummiesGen$Sports <- Sports
dfDummiesGen$Strategy <- Strategy


dummyPlat <- toDummyPlat(df$Platform)

dfDummiesPlat2 <- df[,-3]
dfDummiesPlat2$Plataform <- dummyPlat



####### Tentando melhorar o japao #######

mod_JP2_G <- lm(Global_Sales ~ JP_Sales+DS3+DS+DC+PC+PS2+PS3+PSP+PSV+Wii+X360+
                  JP_Sales:DS3:DS:PC:PS2:PS3:PSP:PSV:Wii:X360
                , data = dfDummies)

mod_JP2_1_G <- lm(Global_Sales ~ JP_Sales+Plataform+
                  JP_Sales:Plataform
                , data = dfDummiesPlat2)

mod_JP3_G <- lm(Global_Sales ~ JP_Sales+
                  Action+Adventure+Fighting+Platform+Racing+RPG+Shooter+Sports+Strategy+
                  JP_Sales:Action:Adventure:Fighting:Platform:Racing:RPG:Shooter:Sports:Strategy
                , data = dfDummiesGen)

mod_JP4_G <- lm(Global_Sales ~ JP_Sales+
                  DS3+DS+DC+PC+PS2+PS3+PSP+PSV+Wii+X360+
                  Action+Adventure+Fighting+Platform+Racing+RPG+Shooter+Sports+Strategy+
                  JP_Sales:DS3:DS:PC:PS2:PS3:PSP:PSV:Wii:X360:
                  Action:Adventure:Fighting:Platform:Racing:RPG:Shooter:Sports:Strategy
                , data = dfDummies)

################ Testes de regressao ################


################ exportando pra xlsx  ################

#write.xlsx(distMeans, file="distancias.xlsx") 

# Plataform
frPlataform <- frequencia(df$Platform, "Plataform", FALSE)
write.xlsx(frPlataform, file="Plataform-fr.xlsx") 
moda(df$Platform) #DS
###

# Jp
frJp <- frequencia(df$Platform, "Plataform", FALSE)
write.xlsx(frPlataform, file="Plataform-fr.xlsx") 
moda(df$Platform) #DS
###

# Year
frYear <- frequencia(df$Year, "Year", FALSE)
write.xlsx(frYear, file="Year-fr.xlsx")
moda(df$Year) #2009
###

# Genre
frGenre <- frequencia(df$Genre, "Genre", FALSE)
write.xlsx(frGenre, file="Genre-fr.xlsx")
moda(df$Genre) # Action
###

# Publisher
frPublisher <- frequencia(df$Publisher, "Publisher", FALSE)
write.xlsx(frPublisher, file="Publisher-fr.xlsx")
moda(df$Publisher) # Eletronic Arts
###

# NA_Sales
frNA_Sales <- frequencia(df$NA_Sales, "NA_Sales", TRUE)
pdNA_Sales <- posDisp(df$NA_Sales)
write.xlsx(frNA_Sales, file="NA_Sales-fr.xlsx")
write.xlsx(pdNA_Sales, file="NA_Sales-pd.xlsx")
###

# Eu_Sales
frEU_Sales <- frequencia(df$EU_Sales, "EU_Sales", TRUE)
pdEU_Sales <- posDisp(df$EU_Sales)
write.xlsx(frEU_Sales, file="EU_Sales-fr.xlsx")
write.xlsx(pdEU_Sales, file="EU_Sales-pd.xlsx")

###

# JP_Sales
frJP_Sales <- frequencia(df$JP_Sales, "Jp_Sales", TRUE)
pdJP_Sales <- posDisp(df$JP_Sales)
write.xlsx(frJP_Sales, file="JP_Sales-fr.xlsx")
write.xlsx(pdJP_Sales, file="JP_Sales-pd.xlsx")

# Other_Sales
frOther_Sales <- frequencia(df$Other_Sales, "Other_Sales", TRUE)
pdOther_Sales <- posDisp(df$Other_Sales)
write.xlsx(frOther_Sales, file="Other_Sales-fr.xlsx")
write.xlsx(pdOther_Sales, file="Other_Sales-pd.xlsx")
###

# Global_Sales
frGlobal_Sales <- frequencia(df$Global_Sales, "Global_Sales", TRUE)
pdGlobal_Sales <- posDisp(df$Global_Sales)
write.xlsx(frGlobal_Sales, file="Global_Sales-fr.xlsx")
write.xlsx(pdGlobal_Sales, file="Global_Sales-pd.xlsx")
###

lfr <- list(frNA_Sales, frEU_Sales,
            frJP_Sales, frOther_Sales, frGlobal_Sales)
lpd <- list(pdNA_Sales, pdEU_Sales,
            pdJP_Sales, pdOther_Sales, pdGlobal_Sales)
write.xlsx(lfr, file="SalesFrequency.xlsx")
write.xlsx(lpd, file="SalesPD.xlsx")

################ boxplots ################

#Boxplot ano - global
a1 <- df$Global_Sales[df$Year == 2008]
a2 <- df$Global_Sales[df$Year == 2009]
a3 <- df$Global_Sales[df$Year == 2010]
a4 <- df$Global_Sales[df$Year == 2011]

boxplot(a1, a2, a3, a4,
        names = c("2008", "2009", "2010", "2011"),
        col = c("red", "blue", "pink"))
###

#Boxplot plataform-global
p1 <- df$Global_Sales[df$Platform == "DS"]
p2 <- df$Global_Sales[df$Platform == "Wii"]
p3 <- df$Global_Sales[df$Platform == "X360"]

boxplot(p1, p2, p3,
        names = c("DS", "Wii", "X360"),
        ylim = c(0, 1.2),
        col = c("red", "blue", "pink"))
###

#Boxplot genre-global
g1 <- df$Global_Sales[df$Genre == "Action"]
g2 <- df$Global_Sales[df$Genre == "Misc"]
g3 <- df$Global_Sales[df$Genre == "Sports"]

boxplot(g1, g2, g3,
        names = c("Action", "Misc", "Sports"),
        ylim = c(0, 1.2),
        col = c("red", "blue", "pink"))
###

#Boxplot publisher-global
pub1 <- df$Global_Sales[df$Publisher == "Electronic Arts"]
pub2 <- df$Global_Sales[df$Publisher == "Activision"]
pub3 <- df$Global_Sales[df$Publisher == "Ubisoft"]

boxplot(pub1, pub2, pub3,
        names = c("EA", "Activision", "Ubisoft"),
        col = c("red", "blue", "pink"))
###

################ Calculo de outliers + boxplots  ################

# Quartis
r1 <- df$Global_Sales #r1 sera a coluna analisada
qr1 <- quantile(r1)

# Limites
l1 <- limites(qr1)


# outliers
out_1 <- r1[r1 > l1[1] | r1 < l1[2]]

boxplot(r1)
boxplot(r1,
        ylim = c(0, 1.2),
        col = c("blue")
)
###

### Exemplo de dispersao
g = plot(df$Global_Sales ~
         df$JP_Sales,
         pch = 16,
         xlim = c(0, 1.2),
         ylim = c(0, 1.2),
         xlab = "JP Sales",
         ylab = "Global Sales",
         col = c("red", "blue"))
grid(g) #aplicando grid ao gráfico
