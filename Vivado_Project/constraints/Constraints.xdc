##Clock signal
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS18 } [get_ports { iClk }];

##Pmod Header JE
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS18 } [get_ports { iUART }];
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS18 } [get_ports { oUART }];

##LEDs
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS18 } [get_ports { oGPIO }];

##Pmod Header JC
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS18 } [get_ports { ioSDA }];              
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS18 } [get_ports { ioSCL }];

## Audio Codec
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS18 } [get_ports { ioSDIN }];