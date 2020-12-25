#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(){

    int id = fork();
    if(id == 0) printf("Child: Hello World\n");
    else printf("Main: Hello World\n");

}