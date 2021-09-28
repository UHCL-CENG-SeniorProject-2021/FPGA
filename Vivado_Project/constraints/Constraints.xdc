#set_property IOSTANDARD LVCMOS25 [get_ports iRESET]

##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS25 } [get_ports { iCLK }]; #IO_L12P_T1_MRCC_35 Sch=sysclk 

#Pmod Header JC
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS25 } [get_ports { ioSDA }]; #IO_L8P_T1_34 Sch=jc_p[3]              
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS25 } [get_ports { ioSCL }]; #IO_L8N_T1_34 Sch=jc_n[3]   
##Audio Codec
set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS25 } [get_ports { oBCLK }]; #IO_0_34 Sch=ac_bclk
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS25 } [get_ports { oMCLK }]; #IO_L19N_T3_VREF_34 Sch=ac_mclk
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS25 } [get_ports { oMUTE }]; #IO_L23N_T3_34 Sch=ac_muten
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS25 } [get_ports { oPBDAT }]; #IO_L20N_T3_34 Sch=ac_pbdat
set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS25 } [get_ports { oPBLRC }]; #IO_25_34 Sch=ac_pblrc
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS25 } [get_ports { iRECDAT }]; #IO_L19P_T3_34 Sch=ac_recdat
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS25 } [get_ports { oRECLRC }]; #IO_L17P_T2_34 Sch=ac_reclrc
set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS25 } [get_ports { oSCLK }]; #IO_L13P_T2_MRCC_34 Sch=ac_scl
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS25 } [get_ports { ioSDIN }]; #IO_L23P_T3_34 Sch=ac_sda
