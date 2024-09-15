#include <stdio.h>
#include <cuda_runtime.h>

int sum(int *a, int size);
__global__ void dot_product(int *a, int *b, int *c, int size);

int main()
{
  int n = 5;
  int size = n * sizeof(int);

  int a[] = {1, 2, 3, 4, 5};
  int b[] = {1, 2, 3, 4, 5};
  int c[5] = {0};

  int *d_a, *d_b, *d_c;

  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

  dot_product<<<1, n>>>(d_a, d_b, d_c, n);

  // Ensure the kernel finishes executing
  cudaDeviceSynchronize();

  cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

  int result = sum(c, n);

  printf("Sum of dot product result: %d\n", result);

  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  return 0;
}

__global__ void dot_product(int *a, int *b, int *c, int size)
{
  int indx = threadIdx.x + blockIdx.x * blockDim.x;

  if (indx < size)
  {
    c[indx] = a[indx] * b[indx];
    printf("c[%d] = %d\n", indx, c[indx]); // Corrected printf
  }
}

int sum(int *a, int size)
{
  int sum = 0;
  for (int i = 0; i < size; i++)
  {
    sum += a[i];
  }

  return sum;
}
