#include <stdlib.h>
#include <stdio.h>
#define true 1
#define false 0
#define IDADEPREFERENCIAL 60

typedef int bool;

typedef struct aux {
  int id; //chave
  int idade;
  struct aux* prox;
} ELEMENTO, * PONT;

typedef struct {
  PONT inicio; //primeira pessoa da fila ou null
  PONT fimPref; //ultima pessoa preferencial ou null
  PONT inicioNaoPref; //primeira pessoa da fila na preferencial ou null
  PONT fim; //ultima pessoa da fila
} FILAPREFERENCIAL, * PFILA;
