#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>


int main() {

  int d_K = 6;

  int Q[6] = {0.12, 0.30, 021, 0.12, 0.30, 021};
  int K[6] = {0.12, 0.30, 021, 0.12, 0.30, 021};




  return 0;
}


__global__ void *dotProduct(int* q, int* k ) {
  int thread = threadIdx.x + (blockDim.x * blockIdx.x);
  



}

int* softmax(int *S) {
  int len = sizeof(S) / sizeof(S[1]);
  int exp_sum = 0;
  int P[len];
  for(int i = 0; i<len; i++) {
    exp_sum += exp(S[i]);
  }
  for(int i =0; i<len; i++) {
    P[i] = exp(S[i])/exp_sum;
  }

  return P;

}


