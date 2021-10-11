##Clock signal
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS18 } [get_ports { iClk }];

##Pmod Header JE
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS18 } [get_ports { iUART }];
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS18 } [get_ports { oUART }];

##LEDs
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS18 } [get_ports { oGPIO }];

##Pmod Header JC                                                                                                                  
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS18     } [get_ports { iSck  }]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS18     } [get_ports { iCsn  }];
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS18     } [get_ports { oMiso }];              
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS18     } [get_ports { iMosi }];              
#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS18     } [get_ports { jc[4] }];              
#set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS18     } [get_ports { jc[5] }];              
#set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS18     } [get_ports { jc[6] }];              
#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS18     } [get_ports { jc[7] }];     

## Audio Codec
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS18 } [get_ports { oBLCK }];
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS18 } [get_ports { oMCLK }];
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS18 } [get_ports { oMUTE }];
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS18 } [get_ports { oPBDAT }];
#set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS18 } [get_ports { oPBLRC }];
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS18 } [get_ports { oRECDAT }];
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS18 } [get_ports { oRECLRC }];
set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS18 } [get_ports { oSCLK }];
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS18 } [get_ports { ioSDIN }];