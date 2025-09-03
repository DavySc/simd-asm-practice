#include <stdio.h>
#include <stdlib.h>

int sum_c(const int *arr, int len) {
  int sum = 0;
  for (int i = 0; i<len; i++) {
    sum = sum + arr[i];
  }
  return sum;
}

int main(int argc, char *argv[])
{
  int array[5] = {1,3,6,10,9};
  int n = sizeof(array)/sizeof(array[0]);
    printf("%d\n", sum_c(array, n));
	return EXIT_SUCCESS;
}
