restart -f;
force -freeze sim:/regr/clk1 1 0, 0 {50 ps} -r 100
force -freeze sim:/regr/clk2 1 50, 0 {100 ps} -r 100
force d 1;
run 300;
force d 0;
run 300;
