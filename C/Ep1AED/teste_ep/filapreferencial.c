#include "filapreferencial.h"
#include <malloc.h>

PFILA criarFila(){ //aloca a memoria para a fila e marca tudo null
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

	//inserir elemento conforme a regra do atendimento preferencial
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




	return false;
}


bool desistirDaFila(PFILA f, int id){



	return false;
}
