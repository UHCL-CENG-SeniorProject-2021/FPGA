set outputDir vivado_prj
set prjName almaz_20t_hdl
set boardName xc7k325tffg900-2
set topName xilinx_wrap

#
# STEP#1: create project
#
create_project $prjName $outputDir -part $boardName -force

#
# STEP#2: setup design sources and constraints
#
set GRLIB_SET {
    ../grlib/lib/grlib/stdlib/version.vhd
    ../grlib/lib/grlib/stdlib/stdlib.vhd
    ../grlib/lib/grlib/stdlib/config_types.vhd
    ../grlib/lib/grlib/stdlib/config.vhd
    ../grlib/lib/grlib/stdlib/stdio.vhd
    ../grlib/lib/grlib/stdlib/testlib.vhd
    ../grlib/lib/grlib/amba/amba.vhd
    ../grlib/lib/grlib/amba/devices.vhd
    ../grlib/lib/grlib/amba/ahbctrl.vhd
    ../grlib/lib/grlib/amba/ahbmst.vhd
    ../grlib/lib/grlib/amba/apbctrl.vhd
    ../grlib/lib/grlib/amba/apbctrlx.vhd
}
set GAISLER_SET {
    ../grlib/lib/gaisler/misc/misc.vhd
    ../grlib/lib/gaisler/misc/ahbram.vhd
    ../grlib/lib/gaisler/misc/ahbstat.vhd
    ../grlib/lib/gaisler/misc/rstgen.vhd
    ../grlib/lib/gaisler/uart/uart.vhd
    ../grlib/lib/gaisler/uart/libdcom.vhd
    ../grlib/lib/gaisler/uart/dcom.vhd
    ../grlib/lib/gaisler/uart/dcom_uart.vhd
    ../grlib/lib/gaisler/uart/ahbuart.vhd
    ../grlib/lib/gaisler/leon3/leon3.vhd
    ../grlib/lib/gaisler/irqmp/irqmp.vhd
}

set TECHMAP_SET {
    ../grlib/lib/techmap/gencomp/gencomp.vhd
    ../grlib/lib/techmap/inferred/memory_inferred.vhd
    ../grlib/lib/techmap/maps/allmem.vhd
    ../grlib/lib/techmap/maps/memrwcol.vhd
    ../grlib/lib/techmap/maps/syncram.vhd
    ../grlib/lib/techmap/maps/syncram_2p.vhd
    ../grlib/lib/techmap/maps/syncrambw.vhd
}

read_vhdl -library grlib $GRLIB_SET
read_vhdl -library techmap $TECHMAP_SET
read_vhdl -library gaisler $GAISLER_SET
read_vhdl -library work $VHDL4O_SET
read_vhdl -library work $SPW_SET

read_vhdl -library work [ glob ../src/hdl/wraps/*.vhd ]

read_xdc ../src/constr/top_full.xdc
add_files -fileset constrs_1 ../src/constr/top_full.xdc

# Update compile order for the fileset 'sources_1'
set_property top $topName [current_fileset]
update_compile_order -fileset sources_1

if { [lindex $argv 0] == "-synth"} {
    #
    # STEP#3: run synthesis and the default utilization report.
    #
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1
}


if { [lindex $argv 0] == "-impl"} {
    #
    # STEP#3: run synthesis and the default utilization report.
    #
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1

    # STEP#4: run logic optimization, placement, route and
    # bitstream generation. Generates design checkpoints, utilization and timing
    # reports, plus custom reports.
    launch_runs impl_1 -to_step write_bitstream
    wait_on_run impl_1
}
