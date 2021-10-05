//Function for generating three d6 rolls
#include <stdlib.h>

void roll_three(int* one, int* two, int* three) {
    *one = rand() % 6 + 1;
    *two = rand() % 6 + 1;
    *three = rand() % 6 + 1;
}


int count_dice(int* one, int* two, int* three){
    if(*one == *two && *two == *three){
        return 3;
    }else if(*one == *two || *two == *three || *one == *three){
        return 2;
    }
    return 1;
}