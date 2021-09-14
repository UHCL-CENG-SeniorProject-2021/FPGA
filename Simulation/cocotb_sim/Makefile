SIM ?= ghdl							# set simulator to GHDL
SIM_ARGS ?= --wave=waveform.ghw		# name the generated waveform
TOPLEVEL_LANG ?= vhdl				# set the HDL language

# add GRLIB sources
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/stdlib/version.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/stdlib/stdlib.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/stdlib/config_types.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/stdlib/config.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/stdlib/stdio.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/stdlib/testlib.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/amba/amba.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/amba/devices.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/amba/ahbctrl.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/amba/ahbmst.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/amba/apbctrl.vhd
VHDL_SOURCES_grlib += ../../Vivado_Project/grlib-main/lib/grlib/amba/apbctrlx.vhd
# add GAISLER sources
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/misc/misc.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/misc/rstgen.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/misc/grgpio.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/uart/uart.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/uart/libdcom.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/uart/dcom.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/uart/dcom_uart.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/uart/ahbuart.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/uart/apbuart.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/spi/spi.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/spi/spictrlx.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/spi/spictrl.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/leon3/leon3.vhd
VHDL_SOURCES_gaisler += ../../Vivado_Project/grlib-main/lib/gaisler/irqmp/irqmp.vhd
# add TECHMAP sources
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/gencomp/netcomp.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/gencomp/gencomp.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/inferred/memory_inferred.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/alltech/allmem.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/maps/memrwcol.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/maps/syncram_2p.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/maps/syncram.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/maps/syncrambw.vhd
VHDL_SOURCES_techmap += ../../Vivado_Project/grlib-main/lib/techmap/maps/spictrl_net.vhd
# add project sources
VHDL_SOURCES += ../../Vivado_Project/logic_top.vhd
VHDL_SOURCES += ../../Vivado_Project/test_top.vhd

# set project top
TOPLEVEL = test_top

# set the test bench
MODULE = tbc

# cocotb makefile config
include $(shell cocotb-config --makefiles)/Makefile.sim
