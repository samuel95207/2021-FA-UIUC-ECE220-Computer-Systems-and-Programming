#include <stdio.h>
#include <stdlib.h>

/*
  Intro Paragraph:
  partners: swhuang3, ycc6, dhhuang3
  Define a function to calcuate conbination,
  then use for loop to iterate each col element in the give row.
  partners: swhuang3, ycc6, dhhuang3
*/

unsigned long long conbination(int n, int k);

int main() {
    int row;

    printf("Enter a row index: ");
    scanf("%d", &row);

    // Write your code here

    // Iterate each col element in the give row.
    for (int i = 0; i <= row; i++) {
        unsigned long long result = conbination(row, i);    // Calculate C(row, i)
        printf("%llu ", result);
    }

    printf("\n");

    return 0;
}

/*
Conbination function
input: int n, int k
output: unsigned long long C(n, k)
*/
unsigned long long conbination(int n, int k) {
    // c(n,k) = c(n,n-k), use it to reduce calculation complexity
    if(k * 2 > n){
        k = n - k;
    }
    unsigned long long result = 1;
    for (int i = 1; i <= k; i++) {
        // split '*' and '/' calculation to prevent persision error cause by integer division
        result *= (n + 1 - i);
        result /= i;
    }
    return result;
}