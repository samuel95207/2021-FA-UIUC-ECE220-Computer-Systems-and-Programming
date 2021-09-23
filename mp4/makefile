TARGET = ./mp4.out
all:
	gcc -g -O0 -std=c99 -Wall -Werror semiprime.c main.c -o ${TARGET}
run:
	@make all
	@echo 
	@echo Running ${TARGET}
	@${TARGET}
clean:
	@rm ${TARGET}