#include <stdio.h>
#include <cuda_runtime.h>

int main() {
    int devCount = 0;
    cudaError_t err = cudaGetDeviceCount(&devCount);

    if (err != cudaSuccess) {
        printf("Failed to get device count: %s\n", cudaGetErrorString(err));
        return -1;
    }

    printf("Number of CUDA devices: %d\n", devCount);
    return 0;
}
