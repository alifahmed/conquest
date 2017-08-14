##################################################################
#
#	Concolic Makefile
#
##################################################################

IVERILOG_DIR = /home/alif/_tools/_developed/verilog-10.0
IVERILOG_BIN = $(IVERILOG_DIR)/bin
IVERILOG_LIB = $(IVERILOG_DIR)/lib/ivl
IVERILOG_INC = $(IVERILOG_DIR)/include/iverilog


SRC = 	concolic.cpp		\
		event.cpp			\
		expr.cpp    		\
		misc.cpp			\
		numbers.cpp			\
		scope.cpp			\
		stmt.cpp			\
		globals.cpp			\
		logic_lpm.cpp			\
		smt_lib.cpp			\
		simulation.cpp

OBJ = conquest.tgt

.PHONY: all clean

all:
	g++ -o $(IVERILOG_LIB)/$(OBJ) -fpic -shared $(SRC) -I$(IVERILOG_INC) -I. -I$(IVERILOG_DIR) -lyices -g -std=c++11 -Wall -Og -Wno-unused-result

clean:
	rm -f $(IVERILOG_LIB)/$(OBJ)
	
