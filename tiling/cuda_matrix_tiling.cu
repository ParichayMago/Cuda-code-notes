// Steps to perform tiling matrix multiplication
// step 1: Splitting data into smaller tilles
// step 2: Transferring data from G. Mem to shared mem so all the threads in the same block can access it.
// step 3: Dot Product of tiles and storing the value in the registor memroy

#include <cuda_runtime.h>
#define ts 2


__global__ void mat_mul_tiled(float* A, float* B, float* C, int N) {
  int by = blockIdx.y;
  int bx = blockIdx.x;

  int ty = threadIdx.y;
  int tx = threadIdx.x;

  int row = ts * by + ty; //i
  int col = ts * bx + tx; //j

  __shared__ float sh_a[ts][ts];
  __shared__ float sh_b[ts][ts];

  float Pvalue = 0;

  for (int phase=0; phase<N/ts ; phase++) {
  // local index is 2x2 as same as block same as tile
  // row is the same as gloabl index of the thread u got this, and column is the phase*N+tx
    sh_a[ty][tx] = A[(row)*N + phase*ts+tx];
    sh_b[ty][tx] = B[(phase*ts + ty) * ts + col];
    __syncthreads();

    for(int k=0; k<ts; k++){
      Pvalue += sh_a[ty][k] * sh_b[k][tx];
    __syncthreads();
    }
    C[row*N + col ] = Pvalue;
  }
}
 