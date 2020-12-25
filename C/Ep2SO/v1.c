#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>

int count = 0;
int vez = 0;
int running = 1;

void* myFunction(void *arg){
    int meu_id = *(int *)arg;
    int outro;
    if(meu_id == 1) outro = 0;
    else outro = 1;
    printf("Meu id (%i) \n", meu_id);
    while(running == 1){
        while(vez != meu_id){
            printf("(%i) Waiting...\n", meu_id);
            sleep(0.5);
        } 
        //# Regiao critica #
        count++;
        printf("(%i)Count = %i \n", meu_id, count);
        vez = outro;
        printf("Vez = %i \n", vez);
        //# Regiao critica #
    }
}

int main(){

    int n = 0;
    pthread_t myThreads[2];
    int ids[2] = {0,1};

    int i;
    for(i=0; i < 2; i++){
        printf("Criando thread (%i) \n", ids[i]);
        pthread_create(&myThreads[i], NULL, myFunction, (void *)&ids[i]);
    }
    
    while(running == 1){
        n++;
        sleep(1);
        if(n == 10) running = 0;
    };
    
    exit(0);
}
