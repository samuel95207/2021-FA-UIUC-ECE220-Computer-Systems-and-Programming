#include <stdlib.h>
#include <stdio.h>


/*
  Intro Paragraph:
  partners: swhuang3, ycc6, dhhuang3
  Fix: Reverse return bug in is_prime()
  Fix: 2 is not prime bug in is_prime()
  Fix: Replace "k = i % j;" => "k = i / j;" in  print_semiprimes()
  Fix: Add "ret = 1; break;" in  print_semiprimes()
  partners: swhuang3, ycc6, dhhuang3
*/

/*
 * is_prime: determines whether the provided number is prime or not
 * Input    : a number
 * Return   : 0 if the number is not prime, else 1
 */
int is_prime(int number)
{
    int i;
    if (number == 1) {return 0;}
    else if(number == 2) {return 1;}
    for (i = 2; i < number; i++) { //for each number smaller than it
        if (number % i == 0) { //check if the remainder is 0
            return 0;
        }
    }
    return 1;
}


/*
 * print_semiprimes: prints all semiprimes in [a,b] (including a, b).
 * Input   : a, b (a should be smaller than or equal to b)
 * Return  : 0 if there is no semiprime in [a,b], else 1
 */
int print_semiprimes(int a, int b)
{
    int i, j, k;
    int ret = 0;
    for (i = a; i <= b; i++) { //for each item in interval
        //check if semiprime
        for (j = 2; j <= i; j++) {
            if (i%j == 0) {
                if (is_prime(j)) {
                    k = i/j;
                    if (is_prime(k)) {
                        printf("%d ", i);
                        ret = 1;
                        break;
                    }
                }
            }
        }

    }
    printf("\n");
    return ret;

}
