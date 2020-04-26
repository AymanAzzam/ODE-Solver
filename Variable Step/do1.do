#vlog *.v

quit -sim

vsim work.variable_step

radix -unsigned

add wave *

mem load -filltype value -filldata 3 -fillradix unsigned /variable_step/RAM/Mem(0)
mem load -filltype value -filldata 2 -fillradix unsigned /variable_step/RAM/Mem(17)
mem load -filltype value -filldata 3 -fillradix unsigned /variable_step/RAM/Mem(1)
mem load -filltype value -filldata 4 -fillradix unsigned /variable_step/RAM/Mem(2)
mem load -filltype value -filldata 8 -fillradix unsigned /variable_step/RAM/Mem(18)
mem load -filltype value -filldata 6 -fillradix unsigned /variable_step/RAM/Mem(119)
mem load -filltype value -filldata 7 -fillradix unsigned /variable_step/RAM/Mem(120)
mem load -filltype value -filldata 8 -fillradix unsigned /variable_step/RAM/Mem(121)
mem load -filltype value -filldata 11 -fillradix unsigned /variable_step/RAM/Mem(169)
mem load -filltype value -filldata 10 -fillradix unsigned /variable_step/RAM/Mem(170)
mem load -filltype value -filldata 15 -fillradix unsigned /variable_step/RAM/Mem(171)
mem load -filltype value -filldata 0 -fillradix unsigned /variable_step/RAM/Mem(172)
mem load -filltype value -filldata 0 -fillradix unsigned /variable_step/RAM/Mem(3)

force -freeze sim:/variable_step/clk 1 0, 0 {50 ps} -r 100
force reset 1
force enable 0
force start_cal_err 0
run 200 ps
force reset 0
force enable 1
run 200 ps
run 200 ps
run 600 ps
force start_cal_err 1
run 100 ps
force start_cal_err 0
run 1300 ps
force start_cal_err 1
run 100 ps
force start_cal_err 0
run 1400 ps
force start_cal_err 1
run 100 ps
force start_cal_err 0
run 1600 ps
force start_cal_err 1
run 100 ps
force start_cal_err 0
run 2000 ps