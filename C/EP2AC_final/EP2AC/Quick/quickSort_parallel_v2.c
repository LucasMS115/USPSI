#include <stdio.h>
#include <malloc.h>
#include <time.h>
#include <omp.h>
#include <string.h>

int portion_limit = 100;

void write(int *, int, char *);
void quickSortPar(int *, int, int);
void quickSort(int *, int);

void quickSort(int *arr, int length)
{
#pragma omp parallel num_threads(10)
  {
#pragma omp single nowait
    {
      quickSortPar(arr, 0, length - 1);
    }
  }
}

void quickSortPar(int *arr, int p, int r)
{
  int pivot = (p + r) / 2;
  int x = arr[pivot];

  int left = p;
  int right = r;

  while (left <= right)
  {
    while (arr[left] < x)
      left++;

    while (arr[right] > x)
      right--;

    if (left <= right)
    {
      int temp = arr[right];
      arr[right--] = arr[left];
      arr[left++] = temp;
    }
  }

  if ((r - p) < portion_limit)
  {
    if (p < right)
      quickSortPar(arr, p, right);

    if (left < r)
      quickSortPar(arr, left, r);
  }
  else
  {
#pragma omp task
    {
      quickSortPar(arr, p, right);
    }

#pragma omp task
    {
      quickSortPar(arr, left, r);
    }
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
  quickSort(arr, array_size);
  clock_t fim = clock();

  double tempo_gasto = (double)(fim - inicio) / CLOCKS_PER_SEC;

  printf("Tempo gasto: %lf\n", tempo_gasto);

  //LOG
  FILE *log = fopen("../log.csv", "a");
  char logStr[128] = "";
  strcat(logStr, argv[1]);
  strcat(logStr, ", quick_parallel_v2, ");
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
