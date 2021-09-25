---------------------------------------------------------------
-- SSM2603 (on-board audio codec, pg22) device address: 0011010b
-- allows for stereo record and playback at sample rates from 8 kHz to 96 kHz.

-- BCLK     I²S (Serial Clock)              Output         R19
-- PBDAT    I²S (Playback Data)             Output         R18
-- PBLRC    I²S (Playback Channel Clock)    Output         T19
-- RECDAT   I²S (Record Data)               Input          R16
-- RECLRC   I²S (Record Channel Clock)      Output         Y18
-- SDIN     I²C (Data)                      Input/Output   N17
-- SCLK     I²C (Clock)                     Output         N18
-- MUTE     Digital Enable (Active Low)     Output         P18
-- MCLK     Master Clock                    Output         R17
---------------------------------------------------------------
-- Questions
-- Why so many clocks? (iClk_core, iClk_i2s, oBclk, oPblrc, oReclrc, oMclk)
-- What is iNd?
---------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Xilinx leaf cells libs
library UNISIM;
use UNISIM.VComponents.all;

entity i2s_ctrl is
    generic(
        cW : integer := 24              -- Width of left/right channel data buses
    );
    Port (
    -- global signals    
        iClk_core: in std_logic;        -- system clock
        iReset_core: in std_logic;      -- system reset
        enable : Boolean;               -- enable RX
    -- I2S control signals        
        iClk_i2s: in std_logic;         -- i2s clock
        iReset_i2s: in std_logic;       -- i2s reset
    -- internals
        iNd: in std_logic;              -- ?
        iData: in std_logic_vector;     -- 
        oAck: out std_logic;
        oNd: out std_logic;
        oData: out std_logic_vector;
        iAck: in std_logic;
    -- SSM2603
        -- i2s: 2 channels sampled @ BCLK
        oBclk: out std_logic;           -- i2s serial clock
        -- playback channel
        oPbdat: out std_logic;          -- i2s playback data
        oPblrc: out std_logic;          -- i2s playback L/R CLK
        -- record channel
        oRecdat: out std_logic;         -- i2s recorded data
        oReclrc: out std_logic;         -- i2s rec L/R CLK
        -- misc/system
        oMclk: out std_logic;           -- Master Clock
        oMute: out std_logic            -- digital enable (active low)
 ); end i2s_ctrl;

architecture Behavioral of i2s_ctrl is

begin


end Behavioral;
