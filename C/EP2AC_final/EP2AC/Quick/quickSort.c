#include <stdio.h>
#include <malloc.h>
#include <time.h>
#include <string.h>

void write(int *, int, char *);

void swap(int *a, int *b)
{
  int temp = *a;
  *a = *b;
  *b = temp;
}

int particiona(int *A, int esq, int dir)
{
  int x = A[dir];
  int i = esq - 1;
  int j;
  for (j = esq; j < dir; j++)
  {
    if (A[j] <= x)
    {
      i++;
      swap(&A[i], &A[j]);
    }
  }
  swap(&A[i + 1], &A[dir]);
  return i + 1;
}

void quickSort(int *A, int esq, int dir)
{
  if (esq < dir)
  {
    int p = particiona(A, esq, dir);
    quickSort(A, esq, p - 1);
    quickSort(A, p + 1, dir);
  }
}

int main(int argc, char *argv[])
{
  //ler arquivo
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
  //ler arquivo ---

  clock_t inicio = clock();
  quickSort(arr, 0, array_size);
  clock_t fim = clock();

  double tempo_gasto = (double)(fim - inicio) / CLOCKS_PER_SEC;

  printf("Tempo gasto: %lf\n", tempo_gasto);

  //LOG
  FILE *log = fopen("../log.csv", "a");
  char logStr[128] = "";
  strcat(logStr, argv[1]);
  strcat(logStr, ", quick, ");
  fprintf(log, "%s", logStr);
  fprintf(log, "%f\n", tempo_gasto);
  fclose(log);
  //LOG

  write(arr, array_size, argv[1]);

  return 0;
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
