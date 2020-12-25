#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>


void* hello(){
    printf("Hello World!!\n");
    return NULL;
}

int main(){

    pthread_t myThreads[10];

    int i;
    for(i=0; i<10; i++){
        printf("%i ", i);
        pthread_create(&myThreads[i], NULL, hello, NULL);
        pthread_join(myThreads[i], NULL);
    }
    
}
