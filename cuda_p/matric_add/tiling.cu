#include <stdio.h>
#include <cuda_runtime.h>

int main () {
  int a[4][4] = {{1,2,3,4}, {1,2,3,4}, {1,2,3,4}, {1,2,3,4}};
  int b[4][4] = {{1,2,3,4}, {1,2,3,4}, {1,2,3,4}, {1,2,3,4}};

}

// Splitting data into smaller tiles.
// Load tiles into shared memory.
// performing dot product with the shared memory.

__global__ void tiled_sq_matrix_mul_kernel(float* A, float* B, float* C, int N) {
  // tile width NxN factors down to N/w*t
  int TILE_WIDTH = 2;

  // details regarding the thread
  int by = blockIdx.y;
  int bx = blockIdx.x;

  int ty = threadIdx.y;
  int tx = threadIdx.x;

  // working on C[i,j]
  int i = by * blockDim.y + ty;
  int j = bx * blockDim.x + tx;
  

  __shared__ float sh_A[2][2];
  __shared__ float sh_B[2][2];

  int PValue = 0;

  for(int phase=0; phase < N/TILE_WIDTH; phase++) {
    sh_A[ty][tx] = A[(i)*N + phase*TILE_WIDTH + tx];
    sh_B[ty][tx] = B[(phase*TILE_WIDTH + ty) * N+j];
    __syncthreads();

    for(int k = 0; k<TILE_WIDTH; k++) {
      PValue += sh_A[ty][k] * sh_B[k][tx];
      __syncthreads();
    }
    C[i*N+j] = PValue;

  }
}