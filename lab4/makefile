TARGET = ./lab4.out
all:
	gcc -Wall -std=c99 -g lab4.c prime.c -o ${TARGET} -lm
run:
	@make all
	@echo 
	@echo Running ${TARGET}
	@${TARGET}
clean:
	@rm ${TARGET}