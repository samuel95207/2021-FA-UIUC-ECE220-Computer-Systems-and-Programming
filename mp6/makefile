all:
	gcc -Wall -std=c99 -g -I include/ -L lib/ main.c updateBoard.c -o gameoflife.out -lncurses
	gcc -Wall -std=c99 -g test.c updateBoard.c updateBoardGold.o -o test.out
clean:
	rm gameoflife.out
	rm test.out
test:
	@make
	@echo 
	@echo Running test
	@./test.out
