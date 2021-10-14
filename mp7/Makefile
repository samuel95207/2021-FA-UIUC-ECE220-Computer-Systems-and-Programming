
mp7: main.c sudoku.c
	g++ -g -c sudoku.c -o sudoku.obj -no-pie
	g++ -g -c main.c -o main.obj -no-pie
	g++ -g main.obj sudoku.obj sudoku_golden.a -o mp7.out -no-pie

clean:
	rm *.obj mp7.out

sudoku1: mp7
	./mp7.out sudoku1.txt

sudoku2: mp7
	./mp7.out sudoku2.txt

sudoku3: mp7
	./mp7.out sudoku3.txt
