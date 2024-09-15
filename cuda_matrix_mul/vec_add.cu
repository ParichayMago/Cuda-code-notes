#include <stdio.h>

// CUDA kernel to add elements of two arrays
__global__ void add(int *a, int *b, int *c, int n) {
    int index = threadIdx.x;
    if (index < n) {
        c[index] = a[index] + b[index];
    }
}

int main() {
    int n = 5;
    int a[5] = {1, 2, 3, 4, 5};
    int b[5] = {10, 20, 30, 40, 50};
    int c[5] = {0};

    int *d_a, *d_b, *d_c;
    int size = n * sizeof(int);

    // Allocate memory on the device
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    add<<<1, n>>>(d_a, d_b, d_c, n);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    printf("Result:\n");
    for (int i = 0; i < n; i++) {
        printf("%d + %d = %d\n", a[i], b[i], c[i]);
    }

    // Free memory on the device
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
