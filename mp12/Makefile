student: shape.cpp main.cpp
	g++ main.cpp shape.cpp -o mp12.out

verify:  shape.cpp verify.cpp
	g++ -g -no-pie -c shape.cpp -o shape.obj
	g++ -g -no-pie -c verify.cpp -o verify.obj
	g++ -g -no-pie verify.obj shape.obj check.a -o verify_mp12.out

clean:
	rm  *.obj mp12.out verify_mp12.out


