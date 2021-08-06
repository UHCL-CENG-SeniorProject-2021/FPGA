set origin_dir [pwd]
set prjName "FPGA_Project"
set boardName xc7z020clg400-1
set topName zybo_top

# Create project
create_project ${prjName} ./${prjName} -part xc7z020clg400-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${prjName}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${prjName}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC" -objects $obj

#
# Sources
#

set GRLIB_SET {
    ../Vivado_Project/grlib-main/lib/grlib/stdlib/version.vhd
    ../Vivado_Project/grlib-main/lib/grlib/stdlib/stdlib.vhd
    ../Vivado_Project/grlib-main/lib/grlib/stdlib/config_types.vhd
    ../Vivado_Project/grlib-main/lib/grlib/stdlib/config.vhd
    ../Vivado_Project/grlib-main/lib/grlib/stdlib/stdio.vhd
    ../Vivado_Project/grlib-main/lib/grlib/stdlib/testlib.vhd
    ../Vivado_Project/grlib-main/lib/grlib/amba/amba.vhd
    ../Vivado_Project/grlib-main/lib/grlib/amba/devices.vhd
    ../Vivado_Project/grlib-main/lib/grlib/amba/ahbctrl.vhd
    ../Vivado_Project/grlib-main/lib/grlib/amba/ahbmst.vhd
    ../Vivado_Project/grlib-main/lib/grlib/amba/apbctrl.vhd
    ../Vivado_Project/grlib-main/lib/grlib/amba/apbctrlx.vhd
}
set GAISLER_SET {
    ../Vivado_Project/grlib-main/lib/gaisler/misc/misc.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/misc/ahbram.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/misc/ahbstat.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/misc/rstgen.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/uart/uart.vhd
	../Vivado_Project/grlib-main/lib/gaisler/uart/apbuart.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/uart/libdcom.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/uart/dcom.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/uart/dcom_uart.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/uart/ahbuart.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/leon3/leon3.vhd
    ../Vivado_Project/grlib-main/lib/gaisler/irqmp/irqmp.vhd
	../Vivado_Project/grlib-main/lib/gaisler/spi/spi.vhd
	../Vivado_Project/grlib-main/lib/gaisler/spi/spictrl.vhd
	../Vivado_Project/grlib-main/lib/gaisler/spi/spictrlx.vhd
	../Vivado_Project/grlib-main/lib/gaisler/misc/grgpio.vhd
}

set TECHMAP_SET {
    ../Vivado_Project/grlib-main/lib/techmap/gencomp/gencomp.vhd
	../Vivado_Project/grlib-main/lib/techmap/gencomp/netcomp.vhd
    ../Vivado_Project/grlib-main/lib/techmap/inferred/memory_inferred.vhd
    ../Vivado_Project/grlib-main/lib/techmap/alltech/allmem.vhd
    ../Vivado_Project/grlib-main/lib/techmap/maps/memrwcol.vhd
    ../Vivado_Project/grlib-main/lib/techmap/maps/syncram.vhd
    ../Vivado_Project/grlib-main/lib/techmap/maps/syncram_2p.vhd
    ../Vivado_Project/grlib-main/lib/techmap/maps/syncrambw.vhd
	../Vivado_Project/grlib-main/lib/techmap/maps/spictrl_net.vhd
}

read_vhdl -library grlib $GRLIB_SET
read_vhdl -library techmap $TECHMAP_SET
read_vhdl -library gaisler $GAISLER_SET

#read_vhdl -library work [ glob ${origin_dir}/*.vhd]
add_files [glob ${origin_dir}/*.vhd]
add_files [glob ${origin_dir}/ip/*.xci]


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "zybo_top" -objects $obj

#
# Constraints
#

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/constraints/Constraints.xdc"]"
set file_imported [import_files -fileset constrs_1 [list $file]]
set_property -name "target_constrs_file" -value "[get_files Constraints.xdc]" -objects $obj
