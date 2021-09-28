library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_top is
    port (
----------------system signals-----------------
        iCLK: in std_logic;     -- System clock
        iRESET: in std_logic;   -- System reset
-----------------------------------------------
        -- i2c
        ioSDA: inout std_logic;
        ioSCL: inout std_logic;
        -- I2S                  -- 2 channels sampled @ BCLK
        oBCLK: out std_logic;   -- i2s clock
        -- playback channel
        oPBDAT: out std_logic;  -- i2s playback data
        oPBLRC: out std_logic;  -- i2s playback L/R CLK
        -- record channel
        iRECDAT: in std_logic;  -- i2s recorded data
        oRECLRC: out std_logic; -- i2s rec L/R CLK
        -- audio control i2c
        oSCLK: out std_logic;
        ioSDIN: inout std_logic;
        -- misc/system
        oMUTE: out std_logic;
        oMCLK: out std_logic
    );

attribute loc: string;
attribute loc of iCLK:    signal is "K17";  -- 125 MHz pin, set to 50MHz
attribute loc of oBCLK:   signal is "R19";  -- I²S (Serial Clock)
attribute loc of oPBDAT:  signal is "R18";  -- I²S (Playback Data)
attribute loc of oPBLRC:  signal is "T19";  -- I²S (Playback Channel Clock)
attribute loc of iRECDAT: signal is "R16";  -- I²S (Record Data)
attribute loc of oRECLRC: signal is "Y18";  -- I²S (Record Channel Clock)
attribute loc of ioSDIN:  signal is "N17";  -- I²C (Data)
attribute loc of oSCLK:   signal is "N18";  -- I²C (Clock)
attribute loc of oMUTE:   signal is "P18";  -- Digital Enable (Active Low)
attribute loc of oMCLK:   signal is "R17";  -- Master Clock
attribute loc of ioSDA:   signal is "W14";  -- I/O pin, JC Pmod
attribute loc of ioSCL:   signal is "Y14";  -- I/O pin, JC Pmod
        
end entity;

architecture Behavioral of test_top is

constant cIO_n: natural := 3; -- number of inout pins

component i2s_basic is
    port(
    ------------------- global signals -------------------    
        iClk_core: in std_logic;        -- system clock
        iReset_core: in std_logic;      -- system reset
    ------------------------------------------------------
        -- i2s: 2 channels sampled @ BCLK
        oBclk: out std_logic;           -- i2s serial clock
        -- playback channel
        oPbdat: out std_logic;          -- i2s playback data
        oPblrc: out std_logic;          -- i2s playback L/R CLK
        -- record channel
        iRecdat: in std_logic;          -- i2s recorded data
        oReclrc: out std_logic;         -- i2s rec L/R CLK
        -- misc/system
        oMclk: out std_logic;           -- Master Clock
        oMute: out std_logic            -- digital enable (active low)
    );
    end component;

    component zybo_glue
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
    end component;

    signal sIO_idata: std_logic_vector (cIO_n-1 downto 0);
    signal sIO_en: std_logic_vector (cIO_n-1 downto 0);
    signal sIO_odata: std_logic_vector (cIO_n-1 downto 0);
    signal sClk_core: std_logic;
    signal sReset_core: std_logic;
    signal sClk_i2s: std_logic;
    signal sReset_i2s: std_logic;

begin

    glue: zybo_glue port map (
    -- clocks
        iCLK => iCLK,
        oClk_core => sClk_core,
        oReset_core => sReset_core,
        oClk_i2s => sClk_i2s,
        oReset_i2s => sReset_i2s,

    -- IO buffers
        iIO_data => sIO_idata,
        iIO_en => sIO_en,
        oIO_data => sIO_odata,
        ioIO_pins(0) => ioSDA,
        ioIO_pins(1) => ioSCL,
        ioIO_pins(2) => ioSDIN
    );

    i2s_test: i2s_basic port map(
        iClk_core => sClk_core,
        iReset_core => sReset_core,     
        oBclk => oBclk,
        oPbdat => oPbdat,
        oPblrc => oPblrc,
        iRecdat => iRecdat,
        oReclrc => oReclrc,
        oMclk => oMclk,
        oMute => oMute
    );

end Behavioral;