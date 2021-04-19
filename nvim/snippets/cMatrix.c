Key binding: <leader>cpm
Move cursor:
Code:
void printMatrix(int n, int m, int** t)
{
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) 
			printf("%2d ", t[i][j]);
	printf("\n");
	}
}
