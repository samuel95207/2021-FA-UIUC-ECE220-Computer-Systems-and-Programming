
#include <stdio.h>


#include "cmp_mat.h"
#ifndef SP_MAT
#define SP_MAT
#include "sparsemat.h"
#endif

int main(int argc, char *argv[]){
    sp_tuples * mat = load_tuples(argv[1]);
    printMat(mat);
    printList(mat);

    destroy_tuples(mat);

}