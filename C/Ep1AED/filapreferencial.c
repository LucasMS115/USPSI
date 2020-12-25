#include "filapreferencial.h"
#include <malloc.h>

PFILA criarFila(){ 
	PFILA res = (PFILA) malloc(sizeof(FILAPREFERENCIAL));
	res->inicio = NULL;
	res->fimPref = NULL;
	res->inicioNaoPref = NULL;
	res->fim = NULL;
	return res;
}

int tamanho(PFILA f){
	PONT atual = f->inicio;
	int tam = 0;
	while (atual) {
		atual = atual->prox;
		tam++;
	}
	return tam;
}

PONT buscarID(PFILA f, int id){
	PONT atual = f->inicio;
	 while (atual) {
		if (atual->id == id) return atual;
		atual = atual->prox;
	}
	return NULL;
}

PONT buscaExc(PFILA l, int id, PONT* ant){
  *ant = NULL;
  PONT atual = l->inicio;
  while (atual){
	if (atual->id == id) return atual;
    *ant = atual;
    atual = atual->prox;
  }
  return NULL;
}

void exibirLog(PFILA f){
	int numElementos = tamanho(f);
	printf("\nLog fila [elementos: %i] - Inicio:", numElementos);
	PONT atual = f->inicio;
	while (atual){
		printf(" [%i;%i]", atual->id, atual->idade);
		atual = atual->prox;
	}
	printf("\n\n");
}


int consultarIdade(PFILA f, int id){
	PONT atual = f->inicio;
	 while (atual) {
		if (atual->id == id) return atual->idade;
		atual = atual->prox;
	}
	return -1;
}



bool inserirPessoaNaFila(PFILA f, int id, int idade){

	if(buscarID(f,id) != NULL || idade < 0)return false;

	PONT novo = (PONT)malloc(sizeof(ELEMENTO));

	novo->id = id;
	novo->idade = idade;

	if(idade >= IDADEPREFERENCIAL){
		if (f->inicio == NULL){ // fila vazia
			f->inicio = novo;
			f->fimPref = novo;
			f->fim = novo;
			novo->prox = NULL;
			return true;
		}else if(f->fimPref == NULL){ // fila so tem naoPref
			f->inicio = novo;
			f->fimPref = novo;
			novo->prox = f->inicioNaoPref;
			return true;
		}else if(f->inicioNaoPref == NULL){ //fila so tem pref
			f->fimPref->prox = novo;
			f->fimPref = novo;
			f->fim = novo;
			novo->prox = NULL;
			return true;
		}else{ // tem nas duas
			f->fimPref->prox = novo;
			f->fimPref = novo;
			novo->prox = f->inicioNaoPref;
			return true;
		}
	}else{ 
		if (f->inicio == NULL){ // fila vazia
			f->inicio = novo;
			f->inicioNaoPref = novo;
			f->fim = novo;
			novo->prox = NULL;
			return true;
		}else if(f->fimPref == NULL){ // fila so tem naoPref
			f->fim->prox = novo;
			f->fim = novo;
			novo->prox = NULL;		
			return true;
		}else if(f->inicioNaoPref == NULL){ //fila so tem pref
			f->inicioNaoPref = novo;
			f->fimPref->prox = novo;
			f->fim = novo;
			novo->prox = NULL;
			return true;
		}else{ // tem nas duas
			f->fim->prox = novo;
			f->fim = novo;
			novo->prox = NULL;
			return true;
		}	
	}

	return false;
}

bool atenderPrimeiraDaFila(PFILA f, int* id){

	if(f->inicio == NULL)return false;

	PONT aux = f->inicio;

	*id = f->inicio->id;

	if(f->inicio->prox == f->inicioNaoPref){ //se era a ultima pref
		f->inicio = f->inicioNaoPref;
		f->fimPref = NULL;
	}else if(f->fimPref == NULL){ // se so tem nao pref
		f->inicio = f->inicio->prox;
		f->inicioNaoPref = f->inicioNaoPref->prox;
	}else{
		f->inicio = f->inicio->prox;
	}

	free(aux);

	return true;
}


bool desistirDaFila(PFILA f, int id){

	PONT anterior = NULL;
	PONT desistente = buscaExc(f, id, &anterior);
	if(desistente == NULL)return false;

	if(f->inicio == f->fim && f->inicio->id == id){ // unica da fila
		f->inicio = NULL;
		f->fimPref = NULL;
		f->inicioNaoPref = NULL;
		f->fim = NULL;
	}else if(f->inicio->id == id){ // primeira da fila
		f->inicio = f->inicio->prox;
	}else if(f->inicioNaoPref->id == id){ //primeira sem pref
		f->fimPref->prox = f->inicioNaoPref->prox;
		f->inicioNaoPref = f->inicioNaoPref->prox;
	}else if(f->fimPref->id == id){ // ultima pref
		anterior->prox = f->fimPref->prox;
		f->fimPref = anterior;
	}else if(f->fim->id == id){ // ultima da fila
		anterior->prox = f->fim->prox;
		f->fim = anterior;
	}else{
		anterior->prox = desistente->prox;
	}

	free(desistente);

	return true;
}
