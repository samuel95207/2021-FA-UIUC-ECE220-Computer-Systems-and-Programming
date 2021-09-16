#include <stdio.h>
#include <stdlib.h>


unsigned long long conbination(int n, int k);

int main() {
    int row;

    printf("Enter a row index: ");
    scanf("%d", &row);

    // Write your code here

    for(int i = 0;i <= row;i++){
      unsigned long long result = conbination(row,i);
      printf("%d ", result);
    }

    printf("\n");

    return 0;
}

unsigned long long conbination(int n, int k) {
    unsigned long long result = 1;
    for (int i = 1; i <= k; i++) {
        result *= (n + 1 - i);
    }
    for (int i = 1; i <= k; i++) {
        result /= i;
    }
    return result;
}