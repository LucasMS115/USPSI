#include "filapreferencial.h"
#include <malloc.h>

PFILA criarFila(){
    PFILA res = (PFILA) malloc(sizeof(FILAPREFERENCIAL));
    res->cabeca = (PONT) malloc(sizeof(ELEMENTO));
    res->inicioNaoPref = res->cabeca;
    res->cabeca->id = -1;
    res->cabeca->idade = -1;
    res->cabeca->ant = res->cabeca;
    res->cabeca->prox = res->cabeca;
    return res;
}

int tamanho(PFILA f){
	PONT atual = f->cabeca->prox;
	int tam = 0;
	while (atual != f->cabeca) {
		atual = atual->prox;
		tam++;
	}
	return tam;
}

PONT buscarID(PFILA f, int id){
	PONT atual = f->cabeca->prox;
	while (atual != f->cabeca) {
		if (atual->id == id) return atual;
		atual = atual->prox;
	}
	return NULL;
}

void exibirLog(PFILA f){
	int numElementos = tamanho(f);
	printf("\nLog fila [elementos: %i]\t- Inicio:", numElementos);
	PONT atual = f->cabeca->prox;
	while (atual != f->cabeca) {
		printf(" [%i;%i]", atual->id, atual->idade);
		atual = atual->prox;
	}
	printf("\n                       \t-    Fim:");
	atual = f->cabeca->ant;
	while (atual != f->cabeca) {
		printf(" [%i;%i]", atual->id, atual->idade);
		atual = atual->ant;
	}
	printf("\n\n");

}

void exibirPont(PFILA f){
	printf("Cabeca = %i ; Cabeca->prox = %i ; Cabeca->ant = %i \n",
					f->cabeca->id, f->cabeca->prox->id, f->cabeca->ant->id);
	printf("inicioNaoPref = %i ; inicioNaoPref->prox %i ; inicioNaoPref->ant %i \n",
					f->inicioNaoPref->id, f->inicioNaoPref->prox->id, f->inicioNaoPref->ant->id);				
}


int consultarIdade(PFILA f, int id){
	PONT atual = f->cabeca->prox;
	while (atual != f->cabeca) {
		if (atual->id == id) return atual->idade;
		atual = atual->prox;
	}
	return -1;
}



bool inserirPessoaNaFila(PFILA f, int id, int idade){

	if(buscarID(f,id)){
		printf("Chave repetida\n");
		return false;
	}

	if(id < 0 || idade < 0)return false;

	PONT novo = (PONT)malloc(sizeof(ELEMENTO));

	novo->id = id;
	novo->idade = idade;

	if(idade >= IDADEPREFERENCIAL){

		if(f->cabeca->prox == f->inicioNaoPref){
			novo->prox = f->inicioNaoPref;
			novo->ant = f->cabeca;
			f->cabeca->prox = novo;
			f->inicioNaoPref->ant = novo;
			printf("so nao pref/vazia\n");
		}else{
			novo->prox = f->inicioNaoPref;
			novo->ant = f->inicioNaoPref->ant;
			f->inicioNaoPref->ant->prox = novo;
			f->inicioNaoPref->ant = novo;
			printf("Padrao do pref\n");
		}
		return true;
	}else{
		if(f->cabeca->prox == f->cabeca){ // vazia
			f->inicioNaoPref = novo;
			novo->prox = f->cabeca;
			novo->ant = f->cabeca;
			f->cabeca->prox = novo;
			f->cabeca->ant = novo;
			printf("Insercao em fila vazia\n");
		}else if(f->inicioNaoPref == f->cabeca){ //so pref
			novo->ant = f->inicioNaoPref->ant;
			novo->prox = f->cabeca;
			f->inicioNaoPref->ant->prox = novo;
			f->cabeca->ant = novo;
			f->inicioNaoPref = novo;
			printf("Insersao com so pref\n");
		}else{
			novo->ant = f->cabeca->ant;
			novo->prox = f->cabeca;
			f->cabeca->ant->prox = novo;
			f->cabeca->ant = novo;
			printf("Insersao comum nao pref\n");
		}

		return true;
	}
	return false;
}

bool atenderPrimeiraDaFila(PFILA f, int* id){

	if(f->cabeca->prox == f->cabeca)return false;
	*id = f->cabeca->prox->id;

	PONT excluir = f->cabeca->prox;

	excluir->prox->ant = f->cabeca;
	f->cabeca->prox = excluir->prox;

	if(excluir == f->inicioNaoPref){
		f->inicioNaoPref = excluir->prox;
	}

	free(excluir);
	return true;

}


bool desistirDaFila(PFILA f, int id){

	PONT excluir = buscarID(f, id);
	if(!excluir) return false;

	excluir->prox->ant = excluir->ant;
	excluir->ant->prox = excluir->prox;

	if(excluir == f->inicioNaoPref){
		f->inicioNaoPref = excluir->prox;
	}

	free(excluir);
	return true;
}
