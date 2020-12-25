

# Selecionar linhas & Ctrl + enter => executar

# Crtl + L limpa o console

# Declaracao de variavel
v1 <- 1
2 -> v2
v3 <- v1+v2
s1 <- "Lucas"
s2 <- "MS"

# Declaracao de funcao '='
f1 = 20

# Help
?c

# Uso da funcao 'c' - cria um array
s3 <- c(s1,s2)

# O raio do array comeca no 1 vei
s3[0]
s3[1]
s3[2]

# Informacoes da variavel (da min max e quartis)
?summary
summary(v3)
summary(s1)
summary(s3)

# rdocumentation.org pra saber de qual pacote eh uma funcao

# instalar um pacote
### install.packages("stringr")
# Precisa chamar o pacote se ele n for padrao
library(stringr)

# Concatenacao de strings
fullName <- str_c(s1, s2)
fullName <- str_c(s1, " ", s2)

#Potencia
p1 <- 4**2
p2 <- 4^2

# E
5 == 5 & v1 == v2
5 == 5 & v1 != v2

# OU
5 == 5 | v1 == v2
5 != 5 | v1 == v2

# Negacao
!(s1 == s2)
! s1 != s2

# Pegar o floor (aparece um L do lado no valor)
piso <- as.integer(15/2)

# Arredondar (vai pra cima no .5)
round1 <- round(15/2)
round2 <- round(5/4)

# identifica qtas vezes os repetidos se repetem
# OBS: O fator parece ser util para quando tem numero mas é qualitativa
fator <- as.factor(c(1,1,2,2,2,5,6,23))
summary(fator)

# Boolean TRUE=1 & FALSE=0
verdade <- TRUE
mentira <- FALSE
ver <- 1==1
men <- 1==2

# Ver se é vetor
is.vector(fator)
mode(fator)

is.vector(v1)
mode(v1)

is.vector(s1)
mode(s1)

is.vector(1)
is.vector("oi")

# Criar lista (repara na lupinha q aparece no Enviroment)
l <- list(c("Salve", "galerinha"),v1, v2, 3, 4, "Lucas", s2, TRUE)

# Acesso lista
l[[2]]
l[[1]] [1]

# Ver se é lista( O tipo vira lista, no vetor, o tipo é o dos itens)
is.list(l)
mode(l)
is.list(s3)
mode(s3)

# Criar matriz
m1 <- matrix(1:9, nrow = 3)
m2 <- matrix(NA, nrow = 5, ncol = 5)

# Acesso matriz
m1[1,2]
m2[1,2]
m2[1,2] <- "gol"

### OBS: (EXEMPLO)SE COLOCAR UM VALOR CHAR EM UMA MATRIZ OU VETOR DE NUM, VIRA TUDO CHAR,

# Definir diretorio 
setwd("C:/Users/adm/Documents/MATERIAS/Semestre-4/MQA")

# Importar base de dados (criar data frame)
library(readxl) #precisa dessa lib pra usar a funcao de pegar do excel
### df <- read.csv("Pesquisa++em+Florianopolis.csv") # de csv
df <- read_excel("Pesquisa++em+Florianopolis.xlsx") # de xls ou xlsx 

# Ver infomacoes do df
str(df)
summary(df)
# Selecionar coluna
ordem <- df[1] # Tem o tipo data frame
class(ordem)
tamanho <- df$tamanho # Tem o tipo dos valores da coluna
class(tamanho)


# Modificar o data frame
df$local <- as.factor(df$local) # Modificar o tipo dos valores da coluna
df$nova <- "Teste" # Cria uma nova coluna e escreve Teste em todas as linhas
df$nova[1:4] <- c(2,3, 20,NA) # Poe os valores do vetor na coluna e linhas 1-4 
df$nova <- NULL # Excluir uma coluna

# Filtros(Exemplos)
df[1,] # Seleciona a linha 1
df[1,2] # Seleciona valores especificos
df$renda[1:5] # Filtra linhas de 1 ate 5
df[-1] # Pega tudo menos a coluna 1
df[-1, ] # Menos a linha 1
df[1:3] # Pega colunas de 1 ate 3
df[1:3,] # menos as inhas de 1 ate 3
df[-(1:3),] # Linhas de 1 ate 3
df[1:5, 1:3] 
df[-3,-5]
df <- df[-7] # Modificando df baseado no resultado da filtragem
df$renda[-5] # Pega tudo menos a row 5
length(df$renda) # Tamanho da coluna
# Por condicao logica
df$tamanho == 4
df[df$tamanho==4,] # Pega as linhas onde o tamanho tem valor 4
df$tamanho[df$tamanho!=4]
df$tamanho[df$tamanho>4]
df$tamanho[df$tamanho<=4]

# Loops for
for(i in df[1,]){
  if(i != 0){
    print(i)
  }else{
    print("ZERO")
  }
}

# Criar funcao

Soma = function(n1, n2){
  print(n1+n2)
  return(list(c(n1,n2,n1+n2)))
}

Soma2 = function(n1, n2){
  a <- n1+n2
  returnValue(a)
}

Soma3 = function(n1, n2){
  retorno <- n1+n2
  return(retorno)
}

teste
teste <- Soma(10,20)
summary(teste)
class(teste)

a <- Soma2(3,7)
Soma3(4,96)

