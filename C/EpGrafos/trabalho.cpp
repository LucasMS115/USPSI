//--------------------------------------------------------------
// NOMES DOS RESPONSÁVEIS: Lucas Mendes Sales
//--------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

// ######### ESCREVA O NROUSP DO PRIMEIRO INTEGRANTE AQUI
int nroUSP1() {
    return 11270736;
}

// ######### ESCREVA O NROUSP DO SEGUNDO INTEGRANTE AQUI (OU DEIXE COM ZERO)
int  nroUSP2() {
    return 0;
}

// ######### ESCREVA O NRO DO GRUPO CADASTRADO
int grupo() {
    return 8;
}

//#define false 0
//#define true 1
//typedef int bool;

typedef struct {
	int bot_lin;
	int bot_col;
	int exit_lin;
	int exit_col;
	int box_col;
	int key_col;
	bool haskey;
} ESTADO, *PEST;

// Elemento da lista / possivel proximo estado
typedef struct auxNo{
    ESTADO est;
	char c; //Caractere que representa o movimento que levou do anterior a este NO
	char* caminho; // caminho do inicio ao NO
    struct auxNo* proxNo;
	int nv; // Altura da arvore em q o vertice se encontra
}NO, *PNO;

typedef struct auxV{
    PNO inicio; //Inicio da lista de nos
	char c;
	int nv;
}VERTICE, *PV;

//************** INICIO FILA **************

//FILA DE NOS
typedef struct {
    PNO inicio;
    PNO fim;
} FILA;

void inicializarFila(FILA* f){
    f->inicio = NULL;
    f->fim = NULL;
};

void destruirFila(FILA* f) {
    PNO end = f->inicio;
    while (end != NULL){
        PNO apagar = end;
        end = end->proxNo;
        free(apagar);
    };
    f->inicio = NULL;
    f->fim = NULL;
};

bool entrarNaFila(FILA* f, PNO no){

    PNO novo = (PNO) malloc(sizeof(NO));

    novo->c = no->c;
	novo->est = no->est;
	novo->caminho = no->caminho;
    novo->proxNo = NULL;
	novo->nv = no->nv;

    if (f->inicio==NULL){
        f->inicio = novo;
    }else{
        f->fim->proxNo = novo;
    };
    f->fim = novo;
    return true;
};

void sairDaFila(FILA* f, PNO* saiu) {
    if (f->inicio==NULL){
        return;
    };
    PNO apagar = f->inicio;
	*saiu = apagar;

    f->inicio = f->inicio->proxNo;
    if (f->inicio == NULL){
        f->fim = NULL;
    };
};

bool filaVazia(FILA* f){
    if(f->inicio == NULL) return true;
    else return false;
};

//************** FIM FILA **************


//Funcao que add o proximo movimento ao vetor do caminho
void caminhoAtual(char* c, char*t, int nv, char move){
	int i;
	for(i = 0; i < nv-1; i++){
		t[i] = c[i];
	};
	t[nv-1] = move;
};


//Cria o no e adiciona ele no inicio da lista de adjacencias do vertice
void addNO(PNO* lista, ESTADO e , char c, char* cAnt, int nv){

    PNO novo = (PNO)malloc(sizeof(NO));
	char* camAt = (char*)malloc(sizeof(char)*nv);

	caminhoAtual(cAnt, camAt, nv+1, c);

	novo->caminho = camAt;
    novo->c = c;
	novo->nv = nv+1;
	novo->est = e;
    novo->proxNo = *lista;
    *lista=novo;
};

ESTADO estado(int bot_lin, int bot_col, int exit_lin, int exit_col, int box_col, int key_col,bool haskey){
    ESTADO s;
	s.bot_lin = bot_lin;
    s.bot_col = bot_col;
	s.exit_lin = exit_lin;
    s.exit_col = exit_col;
	s.box_col = box_col;
	s.key_col = key_col;
	s.haskey = haskey;
    return s;
};

//Cria o vertice e os nos ligados a ele / arestas
PV criarVertice(PNO ant){

	ESTADO s = ant->est;
	ESTADO ini = s;
	PV vertice = (PV)malloc(sizeof(VERTICE));
	vertice->inicio = NULL;
	vertice->nv = ant->nv;
	int proxNv = vertice->nv;

	if(s.exit_lin == 1 || s.exit_col == 2) return vertice;
	if(s.bot_lin == 2 && s.bot_col != s.box_col) return vertice;

	//BOT EM CIMA DA CAIXA
	if(s.bot_lin == 2){

		//BOT COM A CHAVE DO LADO DA PORTA
		if(s.exit_lin == 2 && s.exit_col == s.bot_col && s.haskey == true){
			addNO(&vertice->inicio, ini, 'e', ant->caminho, proxNv);
			return vertice;
		}else if(s.key_col == s.box_col && s.haskey == false){
			//criar estado pega chave
			ini = estado(s.bot_lin, s.bot_col, s.exit_lin, s.exit_col, s.box_col, s.key_col, true);
			addNO(&vertice->inicio, ini ,'g', ant->caminho, proxNv);
		}else{
			//criar estados descendo da caixa
			ini = estado(s.bot_lin+1, s.bot_col, s.exit_lin, s.exit_col, s.box_col, s.key_col, s.haskey);
			addNO(&vertice->inicio, ini ,'d', ant->caminho, proxNv);

			if(s.bot_col > 1){
				ini = estado(s.bot_lin+1, s.bot_col-1, s.exit_lin, s.exit_col, s.box_col, s.key_col, s.haskey);
				addNO(&vertice->inicio, ini ,'l', ant->caminho, proxNv);
			};
			if(s.bot_col < 3){
				ini = estado(s.bot_lin+1, s.bot_col+1, s.exit_lin, s.exit_col, s.box_col, s.key_col, s.haskey);
				addNO(&vertice->inicio, ini ,'r', ant->caminho, proxNv);
			};

		};
	}else if(s.bot_lin == 2 && s.bot_col != s.box_col){
		return NULL;
	};

	if(s.bot_lin == 3){

		//BOT COM A CHAVE DO LADO DA PORTA
		if(s.exit_lin == 3 && s.exit_col == s.bot_col && s.haskey == true){
			addNO(&vertice->inicio, ini, 'e', ant->caminho, proxNv);
			return vertice;
		}else if(s.bot_col == s.box_col){

			//estados de empurrar e subir na caixa
			if(s.bot_col>1){
				ini = estado(s.bot_lin, s.bot_col-1, s.exit_lin, s.exit_col, s.box_col-1, s.key_col, s.haskey);
				addNO(&vertice->inicio, ini ,'L', ant->caminho, proxNv);
			};
			if(s.bot_col < 3){
				ini = estado(s.bot_lin, s.bot_col+1, s.exit_lin, s.exit_col, s.box_col+1, s.key_col, s.haskey);
				addNO(&vertice->inicio, ini ,'R', ant->caminho, proxNv);
			};

			ini = estado(s.bot_lin-1, s.bot_col, s.exit_lin, s.exit_col, s.box_col, s.key_col, s.haskey);
			addNO(&vertice->inicio, ini ,'u', ant->caminho, proxNv);

		}else{
			//estados de andar para os lados
			if(s.bot_col > 1){
				ini = estado(s.bot_lin, s.bot_col-1, s.exit_lin, s.exit_col, s.box_col, s.key_col, s.haskey);
				addNO(&vertice->inicio, ini ,'l', ant->caminho, proxNv);
			};
			if(s.bot_col < 3){
				ini = estado(s.bot_lin, s.bot_col+1, s.exit_lin, s.exit_col, s.box_col, s.key_col, s.haskey);
				addNO(&vertice->inicio, ini ,'r', ant->caminho, proxNv);
			};
		};
	};

	return vertice;
};

/*Baseada no algoritmo de busca em largura. Cria o grafo a partir do estado inicial ate a ocorrencia de um movimento 'e'
 (saida do robo), guarda o caminho da solucao na variavel resp. Nao guarda o grafo.*/
void caminhoValido(PEST s, char* resp){

	if(s->bot_lin>3 || s->bot_lin<2 || s->bot_col>3 || s->bot_col<1 || s->exit_lin < 2|| s->exit_lin>3 || s->exit_col == 2
		|| s->exit_col<1 || s->exit_col>3 || s->box_col<1 || s->box_col>3 || s->key_col<1 || s->key_col>3) return;
	if(s->bot_lin == 2 && s->bot_col != s->box_col) return ;

	FILA f;
	inicializarFila(&f);
	PNO saiu = (PNO)malloc(sizeof(NO));
	PV vn;
	PNO zero = (PNO)malloc(sizeof(NO)); // variavel usada apenal para criar o primeiro vertice
	char z[0];
	zero->caminho = z;
	zero->est = *s;

	PV v1 = criarVertice(zero);

	//se o primeiro vertice ja eh a solucao
	if(v1->inicio->c == 'e'){
		resp[0] = 'e';
		free(zero->caminho);
		free(zero);
		free(v1);
		free(saiu);
		return;
	};

	PNO p1 = v1->inicio;
	while(p1){
		entrarNaFila(&f, p1);
		p1 = p1->proxNo;
	};

	//Os nos criados na funcao criarVertice são colocados na fila e posteriormente usados para criar os proximos vertices
	while(!filaVazia(&f)){
		sairDaFila(&f, &saiu);
		vn = criarVertice(saiu);
		free(saiu->caminho);
		free(saiu);
		PNO pn = vn->inicio;
		while(pn){
			if(vn->inicio->c == 'e'){
			int k;
			for(k = 0; k < pn->nv; k++){
				resp[k] = vn->inicio->caminho[k];
			};
			destruirFila(&f);
			return;
			};
			entrarNaFila(&f, pn);
			pn = pn->proxNo;
		};
		free(vn);
	};
	free(zero->caminho);
	free(zero);
	free(v1);
};

int main()
{
	// exemplo de teste do exemplo 1 da especificacao do EP
	char* resp = (char*) malloc(sizeof(char)*500);
	PEST s = (ESTADO*) malloc(sizeof(ESTADO));
	s->bot_lin=2;
    s->bot_col=1;
	s->exit_lin=2;
    s->exit_col=1;
	s->box_col=1;
	s->key_col=3;
	s->haskey=false;

	caminhoValido(s, resp);
	printf("$ resp -> ");
	int k;
	for(k = 0; k < 500; k++){
		printf("%c", resp[k]);
	};
	printf(" $\n");
};



