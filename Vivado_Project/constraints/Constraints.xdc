#set_property IOSTANDARD LVCMOS25 [get_ports iRESET];

##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS25 } [get_ports { iCLK }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
#create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sysclk }];

##LEDs
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS25 } [get_ports { LED }]; #IO_L23P_T3_35 Sch=led[0]
#set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS25 } [get_ports { LED_Reset }]; #IO_L23N_T3_35 Sch=led[1]
#set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_0_35 Sch=led[2]
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=led[3]

##Pmod Header JC                                                                                                                  
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { iSCK  }]; #IO_L10P_T1_34 Sch=jc_p[1]   			 
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { iCSN  }]; #IO_L10N_T1_34 Sch=jc_n[1]		     
#set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS25 } [get_ports { oMISO }]; #IO_L1P_T0_34 Sch=jc_p[2]              
#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS25 } [get_ports { iMOSI }]; #IO_L1N_T0_34 Sch=jc_n[2]              
#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS25 } [get_ports { ioSDA }]; #IO_L8P_T1_34 Sch=jc_p[3]              
#set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS25 } [get_ports { ioSCL }]; #IO_L8N_T1_34 Sch=jc_n[3]              
#set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { jc[6] }]; #IO_L2P_T0_34 Sch=jc_p[4]              
#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { jc[7] }]; #IO_L2N_T0_34 Sch=jc_n[4]   

##Pmod Header JE 
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS25 } [get_ports { iUART }]; #IO_L4P_T0_34 Sch=je[1]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { oUART }]; #IO_L18N_T2_34 Sch=je[2]
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { je[2] }]; #IO_25_35 Sch=je[3]                          
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { je[3] }]; #IO_L19P_T3_35 Sch=je[4]                     
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { je[4] }]; #IO_L3N_T0_DQS_34 Sch=je[7]                  
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { je[5] }]; #IO_L9N_T1_DQS_34 Sch=je[8]                  
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { je[6] }]; #IO_L20P_T3_34 Sch=je[9]                     
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { je[7] }]; #IO_L7N_T1_34 Sch=je[10]    

##Audio Codec
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS25 } [get_ports { oBCLK }]; #IO_0_34 Sch=ac_bclk
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS25 } [get_ports { oMCLK }]; #IO_L19N_T3_VREF_34 Sch=ac_mclk
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS25 } [get_ports { oMUTE }]; #IO_L23N_T3_34 Sch=ac_muten
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS25 } [get_ports { oPBDAT }]; #IO_L20N_T3_34 Sch=ac_pbdat
#set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS25 } [get_ports { oPBLRC }]; #IO_25_34 Sch=ac_pblrc
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS25 } [get_ports { oRECDAT }]; #IO_L19P_T3_34 Sch=ac_recdat
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS25 } [get_ports { oRECLRC }]; #IO_L17P_T2_34 Sch=ac_reclrc
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS25 } [get_ports { oSCLK }]; #IO_L13P_T2_MRCC_34 Sch=ac_scl
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS25 } [get_ports { ioSDIN }]; #IO_L23P_T3_34 Sch=ac_sda

set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS25 } [get_ports { oGPIO }];