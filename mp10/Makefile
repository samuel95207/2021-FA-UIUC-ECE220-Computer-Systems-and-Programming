CC=gcc
CFLAGS=-g -std=c99 -Wall -Werror -no-pie

all: mp10

mp10: main.obj sparsemat.obj
	$(CC) $(CFLAGS) main.obj sparsemat.obj cmp_mat.o -o mp10.out

main.obj: main.c
	$(CC) $(CFLAGS) -c main.c -o main.obj

sparsemat.obj: sparsemat.c
	$(CC) $(CFLAGS) -c sparsemat.c -o sparsemat.obj

test.obj: test.c 
	$(CC) $(CFLAGS) -c test.c -o test.obj

test: test.obj sparsemat.obj
	$(CC) $(CFLAGS) test.obj sparsemat.obj -o test.out

verify:
	@./mp10.out > matrices/output_mats/mp10_output.txt
	@for f in $(shell ls matrices/output_mats/);do cmp --silent matrices/output_mats/$${f} matrices/gold/$${f} && echo -n '### SUCCESS: Pass verification! ###  ' || echo -n '### ERROR: Failed verification! ###  '; echo $${f}; done

clean:
	rm -f sparsemat.obj main.obj mp10.out test.out
