library ieee;
use ieee.std_logic_1164.all;
Library UNISIM;
use UNISIM.vcomponents.all;

entity zybo_glue is
port (
            -- clocks
            iCLK: in std_logic;
            oClk_core: out std_logic;
            oReset_core: out std_logic;
            oClk_i2s: out std_logic;
            oReset_i2s: out std_logic;

            -- IO buffers
            iIO_data: in std_logic_vector;
            iIO_en: in std_logic_vector;
            oIO_data: out std_logic_vector;
            ioIO_pins: inout std_logic_vector
);
end entity;

architecture behavioral of zybo_glue is

component clk_wiz_0
port (
 -- Clock out ports
 clk_out1: out std_logic;
 clk_out2: out std_logic;
 
 -- Status and control signals
 reset: in std_logic;
 locked: out std_logic;

-- Clock in ports
 clk_in1: in std_logic
);
end component;

signal reset: std_logic;
begin

oReset_core <= not reset;
oReset_i2s <= not reset;

IOBUF_inst1 : IOBUF
   port map (
      O => oIO_data(1),     -- Buffer output
      IO => ioIO_pins(1),   -- Buffer inout port (connect directly to top-level port)
      I => iIO_data(1),     -- Buffer input
      T => iIO_en(1)       -- 3-state enable input, high=input, low=output
   );

IOBUF_inst2 : IOBUF
   port map (
      O => oIO_data(2),     -- Buffer output
      IO => ioIO_pins(2),   -- Buffer inout port (connect directly to top-level port)
      I => iIO_data(2),     -- Buffer input
      T => iIO_en(2)       -- 3-state enable input, high=input, low=output
   );
   
clk_wiz_0_instance: clk_wiz_0
port map (
 -- Clock out ports
 clk_out1 => oClk_core,
 clk_out2 => oClk_i2s,
 
 -- Status and control signals
 reset => '0', -- this will always be enabled
 locked => reset,

-- Clock in ports
 clk_in1 => iCLK
);

   IOBUF_inst : IOBUF

   port map (
      O => oIO_data(0),     -- Buffer output
      IO => ioIO_pins(0),   -- Buffer inout port (connect directly to top-level port)
      I => iIO_data(0),     -- Buffer input
      T => iIO_en(0)       -- 3-state enable input, high=input, low=output
   );
   
   end behavioral;