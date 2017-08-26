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
ExecStep $xv_path/bin/xsim conquest_tb_behav -key {Behavioral:sim_1:Functional:conquest_tb} -tclbatch conquest_tb.tcl -log simulate.log
