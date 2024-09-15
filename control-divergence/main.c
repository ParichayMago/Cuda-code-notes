include <stdio.h>

void matrixKernalAdd(float matrix1, float matrix2, float matrix);

int main () {

  float matrix1[2][2] = [[1,2], [3,4]];
  float matrix2[2][2] = [[1,2], [3,4]];
  float matrix[3][3];
  matrixKernalAdd(matrix1**, matrix2**, matrix);


  return 0;

}

__global__
void matrixKernalAdd(float* matrix1, float* matrix2, float* matrix); {
  int num_rows = sizeof(matrix1[]) / sizeof(flaot);
  int mum_cols = sizeof(matrix1[][]) / sizeof(matrix[]);
  for (int i = 0; i < num_rows; i++) {
    for (int j = 0; j < num_cols; j++) {
      matrix[i][j] = matrix1[i][j] + matrix2[i][j];
      printf("%.f\n", matrix[i][j]);
    }
  }
  return;
}
  
