#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>
#include <semaphore.h>

//hashis
sem_t mutex;
sem_t mutex1;
sem_t mutex2;
sem_t mutex3;
sem_t mutex4;
sem_t* hashis[5];

char* estados[5] = {"-","-","-","-","-"};

int running = 1;

void logEstados(){
    printf("[%s - %s - %s - %s - %s] \n", estados[0], estados[1], estados[2], estados[3], estados[4]);
};

void comer(int filosofo){
    estados[filosofo] = "c";
    //printf("Filosofo(%i): Estou comendo... \n", filosofo);
    logEstados();
    sleep(0.1);
    //printf("Filosofo(%i): Acabei!! \n", filosofo);
}

void acao(int filosofo, int dir){

    estados[filosofo] = "f";
    logEstados();
    //printf("Filosofo(%i): Estou faminto... \n", filosofo);

    sem_wait(hashis[filosofo]);
    sem_wait(hashis[dir]);

    comer(filosofo);

    sem_post(hashis[filosofo]);
    sem_post(hashis[dir]);
    
}

void* vivendo(void *arg){

    int filosofo = *(int *)arg;
    int esq;
    int dir;

    if(filosofo == 0 ) esq = 4;
    else esq = filosofo-1;
    if(filosofo == 4) dir = 0;
    else dir = filosofo+1;

    while(running == 1){
        
        if(estados[esq] != "f" && estados[dir] != "f") acao(filosofo, dir);
        estados[filosofo] = "p";
        logEstados();
        //printf("Filosofo(%i): Estou pensando... \n", filosofo);
        sleep(0.3);
        
    }
}

int main(){

    /*
        estrutura da mesa:
        h = hashi
        f = filosofo
        h0 [f0] h1 [f1] h2 [f2] h3 [f3] h4 [f4] h0 
    */

    hashis[0] = &mutex;
    hashis[1] = &mutex1;
    hashis[2] = &mutex2;
    hashis[3] = &mutex3;
    hashis[4] = &mutex4;

    pthread_t filosofos[5];
    int ids[5] = {0,1,2,3,4};

    int i;
    for(i=0; i <= 4; i++){
        sem_init(hashis[i], 0, 1);
    }

    for(i=0; i <= 4; i++){
        printf("Criando Filósofo (%i) \n", ids[i]);
        pthread_create(&filosofos[i], NULL, vivendo, (void *)&ids[i]);
    }
    
    sleep(30);

    running = 0;
    for(i=0; i <= 4; i++){
        sem_destroy(hashis[i]);
    }
    
    exit(0);
}
