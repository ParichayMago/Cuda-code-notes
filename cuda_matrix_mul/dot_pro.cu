#include <stdio.h>

int main() {
  int n = 5;
  int size = n * sizeof(int);

  int a[] = {1,2,3,4,5};
  int b[] = {1,2,3,4,5};
  int c[] = {0};

  int *d_a, *d_b, *d_c;

  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_c, c, size, cudaMemcpyHostToDevice);

  vector_add<<<1, n>>>(d_a, d_b, d_c, n);



  return 0
}


__global__ void vector_add(int a**, int b**, int **c; int size) {
  for (int i = 0; i <size; i++) {
    c[i] = a[i] * b[i];
  }
  vector_sum();

}


__global__ void vector_sum(int a**, int size){
  int sum =0;
  for(int i =0; i<size; i++) {
    sum += a[i];
  }
  return;
}