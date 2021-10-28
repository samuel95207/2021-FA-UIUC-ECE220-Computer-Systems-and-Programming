CC=gcc
CFLAGS=-g -Wall -Wextra

mp9: main.o maze.o solutionChecker.o
	$(CC) $(CFLAGS) main.obj maze.obj solutionChecker.o -o mp9.out

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.obj

maze.o: maze.c
	$(CC) $(CFLAGS) -c maze.c -o maze.obj

clean:
	rm -f main.obj maze.obj mp9.out


case%:
	@./mp9.out ./tests/maze$(patsubst case%,%,$@).txt