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
	@${TEST} 0 > ./output/test0.txt || true
	@cmp --silent ./output/test0.txt ./solution/test0.txt && echo '### SUCCESS: Pass test 0! ###' || echo '### ERROR: Failed test 0! ###'

	@echo 
	@echo Running test1
	@${TEST} 1 > ./output/test1.txt || true
	@cmp --silent ./output/test1.txt ./solution/test1.txt && echo '### SUCCESS: Pass test 1! ###' || echo '### ERROR: Failed test 1! ###'

	@echo 
	@echo Running test2
	@${TEST} 2 > ./output/test2.txt || true
	@cmp --silent ./output/test2.txt ./solution/test2.txt && echo '### SUCCESS: Pass test 2! ###' || echo '### ERROR: Failed test 2! ###'

	

