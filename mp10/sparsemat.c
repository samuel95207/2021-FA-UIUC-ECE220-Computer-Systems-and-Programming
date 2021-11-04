#include "sparsemat.h"

#include <stdio.h>
#include <stdlib.h>



int tupleCompare(sp_tuples_node* n1, sp_tuples_node* n2) {
    if (n1->row > n2->row) {
        return 1;
    } else if (n1->row < n2->row) {
        return 0;
    }
    return n1->col > n2->col;
}

int tupleEqual(sp_tuples_node* n1, sp_tuples_node* n2) {
    return n1->row == n2->row && n1->col == n2->col;
}

void printMat(sp_tuples* sp) {
    printf("%d %d %d\n", sp->m, sp->n, sp->nz);
    for (int row = 0; row < sp->m; row++) {
        for (int col = 0; col < sp->n; col++) {
            printf("%lf ", gv_tuples(sp, row, col));
        }
        printf("\n");
    }
}

void printList(sp_tuples* sp) {
    printf("%d %d %d\n", sp->m, sp->n, sp->nz);

    sp_tuples_node* iter = sp->tuples_head;

    while (iter != NULL) {
        printf("%d %d %lf\n", iter->row, iter->col, iter->value);
        iter = iter->next;
    }
}

void insertNode(sp_tuples* sp, sp_tuples_node* node) {
    if (sp->tuples_head == NULL) {
        sp->tuples_head = node;
        node->next = NULL;
        sp->nz++;
        return;
    }

    sp_tuples_node* iter = sp->tuples_head;
    while (iter != NULL) {
        sp_tuples_node* next = iter->next;

        if (tupleEqual(iter, node)) {
            iter->value = node->value;
            free(node);
            return;
        }
        if (iter == sp->tuples_head && tupleCompare(iter, node)) {
            sp->tuples_head = node;
            node->next = iter;
            sp->nz++;
            return;
        }
        if (next == NULL) {
            iter->next = node;
            node->next = NULL;
            sp->nz++;
            return;
        }
        if (tupleCompare(node, iter) && tupleCompare(next, node)) {
            node->next = next;
            iter->next = node;
            sp->nz++;
            return;
        }

        iter = iter->next;
    }
}


sp_tuples* constructor(int m, int n) {
    sp_tuples* sp = malloc(sizeof(sp_tuples));
    sp->m = m;
    sp->n = n;
    sp->nz = 0;
    sp->tuples_head = NULL;

    return sp;
}

sp_tuples* load_tuples(char* input_file) {
    FILE* infile = fopen(input_file, "r");
    int m, n;

    fscanf(infile, "%d %d\n", &m, &n);

    sp_tuples* sp = constructor(m, n);

    int row, col;
    double value;

    while (fscanf(infile, "%d %d %lf", &row, &col, &value) == 3) {
        // printf("%d %d %lf\n", row, col, value);
        set_tuples(sp, row, col, value);
    }

    fclose(infile);


    return sp;
}



double gv_tuples(sp_tuples* mat_t, int row, int col) {
    sp_tuples_node* iter = mat_t->tuples_head;
    sp_tuples_node* node = malloc(sizeof(sp_tuples_node));
    node->row = row;
    node->col = col;

    while (iter != NULL) {
        if (tupleEqual(iter, node)) {
            free(node);
            return iter->value;
        } else if (tupleCompare(iter, node)) {
            free(node);
            return 0;
        }
        iter = iter->next;
    }
    free(node);
    return 0;
}


void delete_tuples(sp_tuples* mat_t, int row, int col) {
    sp_tuples_node* iter = mat_t->tuples_head;
    if (iter == NULL) {
        return;
    }

    sp_tuples_node* node = malloc(sizeof(sp_tuples_node));
    node->row = row;
    node->col = col;

    if (tupleEqual(iter, node)) {
        mat_t->tuples_head = iter->next;
        mat_t->nz--;
        free(iter);
        free(node);
        return;
    }

    while (iter->next != NULL) {
        if (tupleEqual(iter->next, node)) {
            sp_tuples_node* tmp = iter->next->next;
            mat_t->nz--;
            free(iter->next);
            iter->next = tmp;
            free(node);
            return;
        } else if (tupleCompare(iter->next, node)) {
            free(node);
            return;
        }
        iter = iter->next;
    }
    free(node);
}

void set_tuples(sp_tuples* mat_t, int row, int col, double value) {
    if (value == 0) {
        delete_tuples(mat_t, row, col);
    } else {
        sp_tuples_node* node = malloc(sizeof(sp_tuples_node));
        node->row = row;
        node->col = col;
        node->value = value;
        // printf("%d %d %lf\n", row, col, value);

        insertNode(mat_t, node);
    }
    return;
}



void save_tuples(char* file_name, sp_tuples* mat_t) {
    FILE* outfile = fopen(file_name, "w");

    fprintf(outfile, "%d %d\n", mat_t->m, mat_t->n);

    sp_tuples_node* iter = mat_t->tuples_head;

    while (iter != NULL) {
        fprintf(outfile, "%d %d %lf\n", iter->row, iter->col, iter->value);
        iter = iter->next;
    }

    fclose(outfile);
    return;
}



sp_tuples* add_tuples(sp_tuples* matA, sp_tuples* matB) {
    sp_tuples* matC = constructor(matA->m, matA->n);

    sp_tuples_node* iter = matA->tuples_head;
    while (iter != NULL) {
        set_tuples(matC, iter->row, iter->col, iter->value);
        iter = iter->next;
    }
    iter = matB->tuples_head;
    while (iter != NULL) {
        double sum = gv_tuples(matC, iter->row, iter->col) + iter->value;
        set_tuples(matC, iter->row, iter->col, sum);
        iter = iter->next;
    }


    return matC;
}



sp_tuples* mult_tuples(sp_tuples* matA, sp_tuples* matB) {
    sp_tuples* matC = constructor(matA->m, matB->n);

    sp_tuples_node* iterA = matA->tuples_head;
    while (iterA != NULL) {
        int rowA = iterA->row;
        int colA = iterA->col;

        sp_tuples_node* iterB = matB->tuples_head;
        while (iterB != NULL) {
            int rowB = iterB->row;
            int colB = iterB->col;

            if (colA == rowB) {
                double sum = gv_tuples(matC, rowA, colB) + gv_tuples(matA, rowA, colA) * gv_tuples(matB, rowB, colB);
                set_tuples(matC, rowA, colB, sum);
            }else if(rowB > colA){
                break;
            }

            iterB = iterB->next;
        }

        iterA = iterA->next;
    }

    return matC;
}



void destroy_tuples(sp_tuples* mat_t) {
    sp_tuples_node* iter = mat_t->tuples_head;

    while (iter != NULL) {
        sp_tuples_node* next = iter->next;
        free(iter);
        iter = next;
    }
    free(mat_t);
    return;
}
