#Makefile for iverilog target

PROJ=conquest

IVERILOG_DIR = /home/alif/_tools/_developed/verilog-10.0
IVERILOG_LIB = $(IVERILOG_DIR)/lib/ivl
IVERILOG_INC = $(IVERILOG_DIR)/include/iverilog

TARGET=$(IVERILOG_LIB)/$(PROJ).tgt
CONFIG_FILE=$(PROJ).conf $(PROJ)-s.conf
CONFIG_TARGET=$(IVERILOG_LIB)/$(PROJ).conf $(IVERILOG_LIB)/$(PROJ)-s.conf

OBJECTS=$(patsubst %.cpp, %.o, $(wildcard *.cpp))
HEADERS=$(wildcard ../include/*.h)

.PHONY: all clean

all: $(TARGET) $(CONFIG_TARGET)


clean:
	@rm -rf *.o
	@rm -rf $(TARGET)


%.o: %.cpp	$(HEADERS)
	@g++ -Wall -g -std=c++11 -c $< -o $@ -I../include/ -I$(IVERILOG_INC) -I$(IVERILOG_DIR) -fpic
	@echo "Compiling $<..."

$(TARGET): $(OBJECTS)
	@g++ $(OBJECTS) -Wall -g -o $@ -std=c++11 -fpic -shared -lyices -Wno-unused-result
	@echo "Linking..."

$(CONFIG_TARGET): $(CONFIG_FILE)
	@cp -f $(CONFIG_FILE) -t $(IVERILOG_LIB)
	@echo "Copying config file..."

