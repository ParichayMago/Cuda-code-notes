
__global__
void vecAddKernal(float* A, float* B, float* C, int n){
	int i = threadIdx.x + blockDim.x * blockIdx.x

	if (i < n) {

		C[i] = A[i] + B[i];
	
	}
	

}

void vecAdd(float* A_h, float* B_h, float* C_h, int n){


	int size = sizeof(flaot) * n;
	float *A_d, *B_d,*C_d;

	cudaMalloc((void **) &A_d, size);
	cudaMalloc((void **) &C_d, size);
	cudaMalloc((void **) &B_d, size);
	
	cudaMemcpy(A_d, A_h, size, cudaMemcpyHostToDevice);
	cudaMemcpy(B_d, B_h, size, cudaMemcpyHostToDevice);
	
	vecAddKernal<<1, 64>>(A_d, B_d, C_d, n);

	cudaDeviceSynchronize();

	cudaMemcpy(C_d, C_h, size, cudaMemcpyDeciceToHost);

	cudaFree(A_d);
	cudaFree(B_d);
	cudaFree(C_d);

}

int main(){

	float matrix1[3][3] = [[1,2,3], [4,5,6], [,7,8,9]]
	float matrix2[3][3] = [[1,2,3], [4,5,6], [,7,8,9]]
	float C[3][3];
	vecAdd(matrix1, matrix2, C, 9);
   		for (int i = 0; i < 9; i++) {
        	printf("%f ", C[i]);
    }
    printf("\n");
    return 0;
}
