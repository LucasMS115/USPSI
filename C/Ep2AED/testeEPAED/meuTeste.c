#include "filapreferencial.c"

int main(){
    PFILA f = criarFila();
	int id;
	int idade;
    
    printf("############# Teste insersao e atender primeira da fila #############\n");
    inserirPessoaNaFila(f, 1, 20);
    exibirPont(f);
    exibirLog(f);

    atenderPrimeiraDaFila(f, &id);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 2, 70);
    exibirPont(f);
    exibirLog(f);

    atenderPrimeiraDaFila(f, &id);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 3, 40);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 4, 20);
    exibirPont(f);
    exibirLog(f);

    atenderPrimeiraDaFila(f, &id);
    exibirPont(f);
    exibirLog(f);

    atenderPrimeiraDaFila(f, &id);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 5, 70);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 6, 80);
    exibirPont(f);
    exibirLog(f);

    atenderPrimeiraDaFila(f, &id);
    exibirPont(f);
    exibirLog(f);

    atenderPrimeiraDaFila(f, &id);
    exibirPont(f);
    exibirLog(f);
    
    printf("\n############# Teste insercao, buscaId e desistir da fila #############\n");    

    inserirPessoaNaFila(f, 1, 20);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f, 1);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 2, 70);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f, 2);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 3, 40);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 4, 20);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f, 4);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f, 3);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 5, 70);
    exibirPont(f);
    exibirLog(f);

    inserirPessoaNaFila(f, 6, 80);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f, 6);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f, 5);
    exibirPont(f);
    exibirLog(f);
    
    inserirPessoaNaFila(f, 1, 34);
    inserirPessoaNaFila(f, 2, 80);
    inserirPessoaNaFila(f, 3, 55);
    inserirPessoaNaFila(f, 4, 60);
    inserirPessoaNaFila(f, 5, 23);
    inserirPessoaNaFila(f, 6, 77);
    exibirPont(f);
    exibirLog(f);

    printf("\n##### BUSCA #####\n\n");

    printf("id 1: %i # ", buscarID(f,1)->id);
    printf("id 2: %i # ", buscarID(f,2)->id);
    printf("id 3: %i # ", buscarID(f,3)->id);
    printf("id 4: %i # ", buscarID(f,4)->id);
    printf("id 5: %i # ", buscarID(f,5)->id);
    printf("id 6: %i \n", buscarID(f,6)->id);

    printf("\n##### CONSULTA #####\n");

    exibirLog(f);
    printf("id 1: %i # ", consultarIdade(f,1));
    printf("id 2: %i # ", consultarIdade(f,2));
    printf("id 3: %i # ", consultarIdade(f,3));
    printf("id 4: %i # ", consultarIdade(f,4));
    printf("id 5: %i # ", consultarIdade(f,5));
    printf("id 6: %i \n", consultarIdade(f,6));

    printf("\n####### DESISTINDO #######\n");

    desistirDaFila(f,1);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f,6);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f,5);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f,2);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f,3);
    exibirPont(f);
    exibirLog(f);

    desistirDaFila(f,4);
    exibirPont(f);
    exibirLog(f);
}