create_clock -period 4167.000 -name clock -waveform {0.000 2083.500} [get_ports -filter { NAME =~  "*clock*" && DIRECTION == "IN" }]

set_property PACKAGE_PIN R2 [get_ports clear_L]
set_property PACKAGE_PIN N3 [get_ports {input[13]}]
set_property PACKAGE_PIN M2 [get_ports {input[15]}]
set_property PACKAGE_PIN H1 [get_ports {input[5]}]
set_property PACKAGE_PIN P3 [get_ports {input[14]}]
set_property PACKAGE_PIN M1 [get_ports {input[12]}]
set_property PACKAGE_PIN L2 [get_ports {input[11]}]
set_property PACKAGE_PIN L1 [get_ports {input[10]}]
set_property PACKAGE_PIN K2 [get_ports {input[9]}]
set_property PACKAGE_PIN J1 [get_ports {input[8]}]
set_property PACKAGE_PIN A15 [get_ports {input[6]}]
set_property PACKAGE_PIN C15 [get_ports {input[4]}]
set_property PACKAGE_PIN B15 [get_ports {input[7]}]
set_property PACKAGE_PIN M3 [get_ports {input[0]}]
set_property PACKAGE_PIN T1 [get_ports enable]
set_property PACKAGE_PIN V8 [get_ports {output[0]}]
set_property PACKAGE_PIN U8 [get_ports {output[1]}]
set_property PACKAGE_PIN W7 [get_ports {output[2]}]
set_property PACKAGE_PIN U7 [get_ports {output[3]}]
set_property PACKAGE_PIN U3 [get_ports {output[4]}]
set_property PACKAGE_PIN W6 [get_ports {output[5]}]
set_property PACKAGE_PIN U2 [get_ports {output[6]}]
set_property PACKAGE_PIN U5 [get_ports {output[7]}]
set_property PACKAGE_PIN V5 [get_ports {output[8]}]
set_property PACKAGE_PIN U4 [get_ports {output[9]}]
set_property PACKAGE_PIN V4 [get_ports {output[10]}]
set_property PACKAGE_PIN W5 [get_ports {output[11]}]
set_property PACKAGE_PIN V3 [get_ports {output[12]}]
set_property PACKAGE_PIN W3 [get_ports {output[13]}]
set_property PACKAGE_PIN V2 [get_ports {output[14]}]
set_property PACKAGE_PIN W2 [get_ports {output[15]}]
set_property PACKAGE_PIN T3 [get_ports clock]
set_property PACKAGE_PIN L3 [get_ports {input[1]}]
set_property PACKAGE_PIN A16 [get_ports {input[2]}]
set_property PACKAGE_PIN K3 [get_ports {input[3]}]
