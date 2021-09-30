TARGET = ./mp5.out
TEST = ./mp5_test.out

all:
	gcc -g -std=c99 -Wall -Werror main.c prog5.c -o ${TARGET}
run:
	@make all
	@echo 
	@echo Running ${TARGET}
	@${TARGET}
clean:
	@rm ${TARGET}
	@rm ${TEST}


test:
	gcc -g -std=c99 -Wall -Werror test.c prog5.c -o ${TEST}
	@echo 
	@echo Running test0
	@${TEST} 0 || true
	@echo 
	@echo Running test1
	@${TEST} 1 || true
	@echo 
	@echo Running test2
	@${TEST} 2 || true
	

