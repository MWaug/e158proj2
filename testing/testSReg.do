restart -f;
force -freeze sim:/flopr/ph1 1 0, 0 {50 ps} -r 100
force -freeze sim:/flopr/ph2 1 50, 0 {100 ps} -r 100
force d 1;
force reset 0;
run 500;
force reset 1;
run 500;
