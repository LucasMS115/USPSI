#include <stdio.h>
#include <malloc.h>
#include <time.h>
#include <string.h>

void selectionSort(int *, int);
void swap(int *, int *);


int main(int argc, char *argv[])
{
  char path[64] = "../Arquivos/";
  strcat(path, argv[1]);
  printf("=> %s\n",path);
  FILE *f = fopen(path, "r");
  int array_size = 0;
  int *arr;

  if (f != NULL)
  {
    int t;
    while (fscanf(f, "%d, ", &t) > 0)
      array_size++;

    fseek(f, 0, SEEK_SET);

    arr = (int *)malloc(sizeof(int) * array_size);

    int i = 0;
    while (fscanf(f, "%d, ", &t) > 0)
      arr[i++] = t;
  }
  else
  {
    puts("Arquivo não encontrado.");
  }

  clock_t inicio = clock();
  selectionSort(arr, array_size);
  clock_t fim = clock();

  double tempo_gasto = (double)(fim - inicio) / CLOCKS_PER_SEC;

  printf("Tempo gasto: %lf", tempo_gasto);

  printf("\n");

  write(arr, array_size, argv[1]);

  //LOG
  FILE *log = fopen("../log.csv", "a");
  char logStr[128] = "";
  strcat(logStr, argv[1]);
  strcat(logStr, ", selection, ");
  fprintf(log, "%s", logStr);
  fprintf(log, "%f\n", tempo_gasto);
  fclose(log);
  //LOG

  return 0;
}

void selectionSort(int *arr, int size)
{
  int i, j;

  for (i = 0; i < size - 1; i++)
  {
    int min = i;

    for (j = i + 1; j < size; j++)
      if (arr[j] < arr[min])
        min = j;

    swap(&arr[i], &arr[min]);
  }
}

void swap(int *x, int *y)
{
  int temp = *x;
  *x = *y;
  *y = temp;
}

void write(int *arr, int size, char *arg)
{

  char path[64] = "../Ordenados/";
  strcat(path, arg);
  strcat(path, "_ORD");
  FILE *f = fopen(path, "w");
  fprintf(f, "%d, ", arr[0]);
  fclose(f);

  f = fopen(path, "a");

  int i;
  for (i = 0; i < size; i++)
  {
    if (i != size - 1)
      fprintf(f, "%d, ", arr[i]);
    else
      fprintf(f, "%d\n", arr[i]);
  }

  fclose(f);
}
