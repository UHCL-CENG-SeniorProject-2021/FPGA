# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/FPGA_Project/FPGA_Project.cache/wt [current_project]
set_property parent.project_path C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/FPGA_Project/FPGA_Project.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/FPGA_Project/FPGA_Project.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library grlib {
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/stdlib/version.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/stdlib/stdlib.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/stdlib/config_types.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/stdlib/config.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/amba/amba.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/amba/devices.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/stdlib/stdio.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/stdlib/testlib.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/amba/ahbctrl.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/amba/ahbmst.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/amba/apbctrl.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/grlib/amba/apbctrlx.vhd
}
read_vhdl -library techmap {
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/gencomp/gencomp.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/alltech/allmem.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/inferred/memory_inferred.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/maps/memrwcol.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/gencomp/netcomp.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/maps/spictrl_net.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/maps/syncram_2p.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/maps/syncram.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/techmap/maps/syncrambw.vhd
}
read_vhdl -library gaisler {
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/misc/misc.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/uart/uart.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/uart/libdcom.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/uart/ahbuart.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/uart/apbuart.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/uart/dcom.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/uart/dcom_uart.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/misc/grgpio.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/leon3/leon3.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/spi/spi.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/misc/rstgen.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/spi/spictrl.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/spi/spictrlx.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/misc/ahbram.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/misc/ahbstat.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib-main/lib/gaisler/irqmp/irqmp.vhd
}
read_vhdl -library xil_defaultlib {
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/FPGA_Project/FPGA_Project.srcs/sources_1/new/test_top.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/logic_top.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/product_top.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/zybo_glue.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/zybo_top.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/counter.vhd
  C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/grlib_tester.vhd
}
read_ip -quiet C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/ip/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all c:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/ip/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/ip/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/ip/clk_wiz_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/FPGA_Project/FPGA_Project.srcs/constrs_1/new/Constraints2.xdc
set_property used_in_implementation false [get_files C:/Users/Bklolo/Desktop/Senior_Proj/FPGA/Vivado_Project/FPGA_Project/FPGA_Project.srcs/constrs_1/new/Constraints2.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top test_top -part xc7z020clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef test_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file test_top_utilization_synth.rpt -pb test_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
