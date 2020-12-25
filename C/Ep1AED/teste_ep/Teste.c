#include "filapreferencial.c"

int main(){

    PFILA f = criarFila();

    printf("Tamanho: %i \n",tamanho(f));
    
    //1
    printf("INSERINDO \n");
    inserirPessoaNaFila(f, 1, 20);

    printf("Tamanho: %i \n",tamanho(f));

    printf(" Inicio: %i\n fimPref: %i\n inicioNaoPref: %i\n fim: %i\n", f->inicio,f->fimPref,f->inicioNaoPref,f->fim);
    //1*

    //2
    printf("INSERINDO \n");
    inserirPessoaNaFila(f, 2, 90);

    printf("Tamanho: %i \n",tamanho(f));

    printf(" Inicio: %i\n fimPref: %i\n inicioNaoPref: %i\n fim: %i\n", f->inicio,f->fimPref,f->inicioNaoPref,f->fim);
    //2*

    //3
    printf("INSERINDO \n");
    inserirPessoaNaFila(f, 3, 90);

    printf("Tamanho: %i \n",tamanho(f));

    printf(" Inicio: %i\n fimPref: %i\n inicioNaoPref: %i\n fim: %i\n", f->inicio,f->fimPref,f->inicioNaoPref,f->fim);
    //3*

    //4
    printf("INSERINDO \n");
    inserirPessoaNaFila(f, 4, 20);

    printf("Tamanho: %i \n",tamanho(f));

    printf(" Inicio: %i\n fimPref: %i\n inicioNaoPref: %i\n fim: %i\n", f->inicio,f->fimPref,f->inicioNaoPref,f->fim);
    //4*
}    