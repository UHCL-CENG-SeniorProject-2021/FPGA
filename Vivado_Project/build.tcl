
# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir [pwd]

# Set the project name
set _xil_proj_name_ "FPGA_Project"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/../project_1"]"

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7z020clg400-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "part" -value "xc7z020clg400-1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC" -objects $obj


add_files [glob ${origin_dir}/*.vhd]
add_files [glob ${origin_dir}/ip/*.xci]

#
# Sources
#

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
puts $file
set file_imported [import_files -fileset constrs_1 [list $file]]
puts $file_imported
set_property -name "target_constrs_file" -value "[get_files Constraints.xdc]" -objects $obj

# TODO: set up grlib/gaisler library for UART comms between fpga and ft232
# and make necessary signal connections between components and pins