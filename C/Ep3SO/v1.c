#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>
#include <semaphore.h>


int count = 0;
sem_t mutex;
int running = 1;

void* myFunction(void *arg){

    int meu_id = *(int *)arg;
    
    while(running == 1){
        
        sem_wait(&mutex);
        //# Regiao critica #
        count++;
        printf("(%i)Count = %i \n", meu_id, count);
        //# Regiao critica #
        sem_post(&mutex);
        
    }
}

int main(){

    pthread_t myThreads[5];
    int ids[5] = {1,2,3,4,5};

    sem_init(&mutex, 0, 1);

    int i;
    for(i=0; i < 5; i++){
        printf("Criando thread (%i) \n", ids[i]);
        pthread_create(&myThreads[i], NULL, myFunction, (void *)&ids[i]);
    }
    
    sleep(0.5);
    running = 0;

    sem_destroy(&mutex);
    
    exit(0);
}
