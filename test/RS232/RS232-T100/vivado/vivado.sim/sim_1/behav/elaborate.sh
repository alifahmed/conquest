#!/bin/bash -f
xv_path="/home/alif/_tools/Xilinx/Vivado/2016.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 12f1eb6fce4f42108d4f2b9c914e3054 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot conquest_tb_behav xil_defaultlib.conquest_tb xil_defaultlib.glbl -log elaborate.log
