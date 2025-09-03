#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern int my_sum_asm(const int *arr, int len);

int sum_c(const int *arr, int len) {
    int sum = 0;
    for (int i = 0; i<len; i++) {
        sum = sum + arr[i];
    }
    return sum;
}

#define N 1000000
int main(void)
{
    int *array = malloc(sizeof(int)*N);
    for (int i = 0; i<N; ++i) array[i] = i%100;

    struct timespec start, end;
    long ns_c, ns_sse;

    // Benchmark C
    clock_gettime(CLOCK_MONOTONIC, &start);
    int sum1 = sum_c(array, N);
    clock_gettime(CLOCK_MONOTONIC, &end);
    ns_c = (end.tv_sec-start.tv_sec)*1e9 + (end.tv_nsec-start.tv_nsec);

    // Benchmark SSE
    clock_gettime(CLOCK_MONOTONIC, &start);
    int sum2 = my_sum_asm(array, N);
    clock_gettime(CLOCK_MONOTONIC, &end);
    ns_sse = (end.tv_sec-start.tv_sec)*1e9 + (end.tv_nsec-start.tv_nsec);

    printf("C sum: %d, time: %ld ns\n", sum1, ns_c);
    printf("SSE sum: %d, time: %ld ns\n", sum2, ns_sse);

    free(array);
    return EXIT_SUCCESS;
}
