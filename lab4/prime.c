#include "prime.h"

int is_prime(int n) {
    // Return 1 if n is a prime, and 0 if it is not
    int i;
    if (n == 1) {
        return 0;
    }
    for (i = 2; i < n; i++) {  // for each number smaller than it
        if (n % i == 0) {      // check if the remainder is 0
            return 0;
        }
    }
    return 1;
}
