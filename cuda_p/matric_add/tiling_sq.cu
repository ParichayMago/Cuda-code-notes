#include <stdio.h>
#include <cuda_runtime.h>

// Assuming equal size sq matrix..

int main()
{
  int a[4][4] = {{1, 2, 3, 4}, {1, 2, 3, 4}, {1, 2, 3, 4}, {1, 2, 3, 4}};
  int b[4][4] = {{1, 2, 3, 4}, {1, 2, 3, 4}, {1, 2, 3, 4}, {1, 2, 3, 4}};
}

// Splitting data into smaller tiles.
// Load tiles into shared memory.
// performing dot product with the shared memory.

__global__ void tiled_sq_matrix_mul_kernel(float *A, float *B, float *C, int N)
{
  // tile width NxN factors down to N/w*t
  int TILE_WIDTH = 2;

  // details regarding the thread
  int by = blockIdx.y;
  int bx = blockIdx.x;

  int ty = threadIdx.y;
  int tx = threadIdx.x;

  // working on C[i,j]
  int Rows = by * TILE_WIDTH + ty;
  int Cols = bx * TILE_WIDTH + tx;

  __shared__ float As[TILE_WIDTH][TILE_WIDTH];
  __shared__ float Bs[TILE_WIDTH][TILE_WIDTH];

  int p_value = 0;
  for (int phase = 0; phase < N / TILE_WIDTH; phase++)
  {
    As[tx][ty] = A[Rows * N + phase * TILE_WIDTH + tx];
    Bs[tx][ty] = B[(phase * TILE_WIDTH + ty) * N + Cols];
    __syncthreads();

    for (int k = 0; k < TILE_WIDTH; k++)
    {
      p_value += As[ty][k] * Bs[k][tx];
    }
    __syncthreads();
  }
  C[Rows * N + Cols] = p_value;
}
