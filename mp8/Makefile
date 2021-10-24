CC=gcc
CFLAGS=-g -std=c99 -Wall #-Werror

all: mp8 mp8_gold

mp8: main.obj game.obj getch_fun.obj
	$(CC) $(CFLAGS) main.obj game.obj getch_fun.obj -o mp8.out -no-pie

mp8_gold: main.obj getch_fun.obj
	$(CC) $(CFLAGS) main.obj test_src/game_gold.o getch_fun.obj -o mp8_gold.out -no-pie

test: test_src/test.obj  game.obj getch_fun.obj
	$(CC) $(CFLAGS) test_src/test.obj test_src/game_test.o game.obj getch_fun.obj -o mp8_test.out -no-pie
	@./mp8_test.out

test_src/test.obj: test_src/test.c
	$(CC) $(CFLAGS) -c test_src/test.c -o test_src/test.obj -no-pie

main.obj: main.c
	$(CC) $(CFLAGS) -c main.c -o main.obj

game.obj: game.c
	$(CC) $(CFLAGS) -c game.c -o game.obj

getch_fun.obj: getch_fun.c
	$(CC) $(CFLAGS) -c getch_fun.c -o getch_fun.obj

clean:
	rm -f getch_fun.obj test_src/test.obj game.obj main.obj mp8.out mp8_gold.out mp8_test.out
