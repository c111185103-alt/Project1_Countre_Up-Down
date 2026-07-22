
set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports clk]

set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports rst]

set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS33} [get_ports up_down]

set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33} [get_ports {count_out[0]}]
set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS33} [get_ports {count_out[1]}]
set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS33} [get_ports {count_out[2]}]
set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS33} [get_ports {count_out[3]}]

