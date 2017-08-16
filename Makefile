###############################################################################
#
# Conquest Makefile
#
###############################################################################
OBJ_WRAP = conquest

OBJECTS = $(patsubst %.c, %.o, $(wildcard ./src/*.cpp))
HEADERS = $(wildcard ./include/*.h)
BUILD_DIR = ./.build


.PHONY: all clean
all: $(OBJ_WRAP)
	@echo "All done!"

%.o: %.cpp $(HEADERS)
	g++ -g -Wall -c $< -o $@

clean:
	-rm -f *.o
#    -rm -f $(TARGET)

$(OBJ_WRAP): conquest.o
	g++ $(BUILD_DIR)/conquest.o -Wall -o $@
	
