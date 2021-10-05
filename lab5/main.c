/* Code to simulate rolling three six-sided dice (D6)
 * User first types in seed value
 * Use seed value as argument to srand()
 * Call roll_three to generate three integers, 1-6
 * Print result "%d %d %d "
 * If triple, print "Triple!\n"
 * If it is not a triple but it is a dobule, print "Double!\n"
 * Otherwise print "\n"
 */

#include <stdio.h>
#include <stdlib.h>

#include "dice.h"


int main() {
    int seed;

    printf("Enter Seed:\n");
    scanf("%d", &seed);

    srand(seed);


    int one, two, three;
    roll_three(&one, &two, &three);

    int countResult = count_dice(&one, &two, &three);
    char* countResultStr = "";
    if (countResult == 2) {
        countResultStr = "Double!";
    } else if (countResult == 3) {
        countResultStr = "Triple!";
    }

    printf("%d %d %d %s\n", one, two, three, countResultStr);


    return 0;
}
