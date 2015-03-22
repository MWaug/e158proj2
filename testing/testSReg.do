restart -f;
force -freeze sim:/regr/clk1 1 0, 0 {50 ps} -r 100
force -freeze sim:/regr/clk2 1 50, 0 {100 ps} -r 100
force sin 1;
run 500;
