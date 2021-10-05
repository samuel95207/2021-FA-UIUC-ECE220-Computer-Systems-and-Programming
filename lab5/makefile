TARGET = ./lab5.out
all:
	gcc -g -Wall -Werror -std=c99 main.c dice.c -o ${TARGET}
run:
	@make all
	@echo 
	@echo Running ${TARGET}
	@${TARGET}
clean:
	@rm ${TARGET}