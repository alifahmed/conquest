
OBJ_WRAP=conquest
SRC_WRAP=./src/conquest.cpp

.PHONY: all clean

all: $(SRC_WRAP)
	@g++ $(SRC_WRAP) -I./include/ -o $(OBJ_WRAP) -std=c++11 -Wall
	
clean:
	rm -f $(OBJ_WRAP)

