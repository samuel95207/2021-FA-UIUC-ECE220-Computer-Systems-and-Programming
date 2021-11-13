
BIN=floorplanner.out

$(BIN): main.c floorplan.c floorplan.h
	g++ -Wall -O3 -no-pie -c floorplan.c -o floorplan.obj
	g++ -Wall -O3 -no-pie -c main.c -o main.obj
	g++ -Wall -O3 -no-pie floorplan.obj main.obj -L./lib -ltest -o $(BIN) 

.PHONY: clean
clean:
	rm floorplanner *.obj

circuit1: $(BIN)
	./$(BIN) circuits/circuit1.txt

circuit2: $(BIN)
	./$(BIN) circuits/circuit2.txt

circuit3: $(BIN)
	./$(BIN) circuits/circuit3.txt

circuit4: $(BIN)
	./$(BIN) circuits/circuit4.txt

circuit5: $(BIN)
	./$(BIN) circuits/circuit5.txt
