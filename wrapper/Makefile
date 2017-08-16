#Makefile for wrapper
OBJ=../conquest

$(OBJ): conquest.cpp ../include/types.h
	@g++ conquest.cpp -Wall -g -std=c++11 -I../include/ -o $(OBJ)
	@echo "Compiling wrapper..."

clean:
	@rm -rf $(OBJ)
	
