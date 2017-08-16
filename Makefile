###############################################################################
#
# Conquest Makefile
#
###############################################################################

.PHONY: all clean

all:
	@make -C src --no-print-directory
	@make -C wrapper --no-print-directory
	@echo "All done!"
	
clean:
	@make -C src clean --no-print-directory
	@make -C wrapper clean --no-print-directory
	@echo "Cleaned!"

