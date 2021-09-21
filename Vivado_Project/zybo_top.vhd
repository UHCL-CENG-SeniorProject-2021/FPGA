-- this wrapper file defines zybo physical interfacing level

library ieee;
use ieee.std_logic_1164.all;

entity zybo_top is
    port (
--------------------------------------------
-- system signals
        iCLK: in std_logic;     -- FPGA clock
        iRESET: in std_logic;   -- FPGA reset
--------------------------------------------
-- rpi comms

        -- uart (tx/rx)
        iUART: in std_logic;
        oUART: out std_logic;

        -- spi (fpga <-> pi)
        iSCK: in std_logic;
        iCSN: in std_logic;
        oMISO: out std_logic;
        iMOSI: in std_logic;

        -- i2c
--        ioSDA: inout std_logic;
--        ioSCL: inout std_logic;

--------------------------------------------
-- SSM2603 (on-board audio codec, pg22) device address: 0011010b
-- allows for stereo record and playback at sample rates from 8 kHz to 96 kHz.


-- BCLK     I²S (Serial Clock)      Output         R19
-- PBDAT    I²S (Playback Data)     Output         R18
-- PBLRC    I²S (Playback Channel   Output         T19
-- Clock)
-- RECDAT   I²S (Record Data)       Input          R16
-- RECLRC   I²S (Record Channel     Output         Y18
-- Clock)
-- SDIN     I²C (Data)              Input/Output   N17
-- SCLK     I²C (Clock)             Output         N18
-- MUTE     Digital Enable (Active  Output         P18
--          Low)
-- MCLK     Master Clock            Output         R17

        -- i2s: 2 channels sampled @ BCLK
        oBCLK: out std_logic; -- i2s clock

        -- playback channel
        oPBDAT: out std_logic; -- i2s playback data
        oPBLRC: out std_logic; -- i2s playback left-right signal
        -- record channel
        oRECDAT: out std_logic; -- i2s recorded data
        oRECLRC: out std_logic; -- i2s rec left-right signal

        -- audio control i2c
        oSCLK: out std_logic;
        ioSDIN: inout std_logic;

        -- misc/system
        oMUTE: out std_logic;
        oMCLK: out std_logic;
        LED: out std_logic;
        LED_Reset: out std_logic        
    ); -- END PORT

    attribute loc: string;
--    attribute loc of iCLK:  signal is "K17";  -- 125 MHz pin
--    attribute loc of iUART:   signal is "V12";  -- Std Pmod JE pg29 z7RM
--    attribute loc of oUART:   signal is "W16";
    attribute loc of iSCK:  signal is "V15";
    attribute loc of iCSN:  signal is "W15";
    attribute loc of oMISO:   signal is "T11";
    attribute loc of iMOSI:   signal is "T10";
--    attribute loc of ioSDA:   signal is "W14";
--    attribute loc of ioSCL:   signal is "Y14";
    -- pg 22: hph out(blk), mic in(pink), line in(blue): J5, J6, J7
    -- pins below located pg22 of Zybo RM
    attribute loc of oBCLK:   signal is "R19";
    attribute loc of oPBDAT:  signal is "R18";
    attribute loc of oPBLRC:  signal is "T19";
    attribute loc of oRECDAT: signal is "R16";
    attribute loc of oRECLRC: signal is "Y18";
    attribute loc of ioSDIN:  signal is "N17";
    attribute loc of oSCLK:   signal is "N18";
    attribute loc of oMUTE:   signal is "P18";
    attribute loc of oMCLK:   signal is "R17";
--    attribute loc of LED:     signal is "M14";          -- LEDs to debug UART
--    attribute loc of LED_Reset: signal is "M15";
   
    signal count_sig: std_logic_vector(23 downto 0);
   
end entity;

architecture v1 of zybo_top is

    constant cIO_n: natural := 3; -- number of inout pins

    -- TODO: define product name
    component product_top
        port (
        -- system signals
            iClk_core: in std_logic;
            iReset_core: in std_logic;
            iClk_i2s: in std_logic;
            iReset_i2s: in std_logic;

        -- rpi comms
            -- uart
            iUart: in std_logic;
            oUart: out std_logic;

            -- spi
            iSck: in std_logic;
            iCsn: in std_logic;
            oMiso: out std_logic;
            iMosi: in std_logic;

            -- i2c
            iSda: in std_logic;
            oSda_e: out std_logic;
            oSda: out std_logic;
            iScl: in std_logic;
            oScl_e: out std_logic;
            oScl: out std_logic;

        -- SSM2603
            -- i2s: 2 channels sampled @ BCLK
--            oBclk: out std_logic; -- i2s clock
--            -- playback channel
--            oPbdat: out std_logic; -- i2s playback data
--            oPblrc: out std_logic; -- i2s playback left-right signal
--            -- record channel
--            oRecdat: out std_logic; -- i2s recorded data
--            oReclrc: out std_logic; -- i2s rec left-right signal

            -- audio control i2c
            oSclk: out std_logic;
            iSdin: in std_logic;
            oSdin_e: out std_logic;
            oSdin: out std_logic;

            -- misc/system
            oMute: out std_logic;
            oMclk: out std_logic
            
--             LED
--            LED: out std_logic
        );
    end component;

    component zybo_glue -- 2nd task
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

    component counter
        port(
            cout   :out std_logic_vector (23 downto 0);
            clk    :in  std_logic;
            reset  :in  std_logic
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

    top: product_top
        port map (
        -- system signals
            iClk_core => sClk_core,
            iReset_core  => sReset_core,
            iClk_i2s => sClk_i2s,
            iReset_i2s  => sReset_i2s,

        -- rpi comms
            -- uart
            iUart => iUart,
            oUart => oUart,

            -- spi
            iSck => iSck,
            iCsn => iCsn,
            oMiSO => oMiSO,
            iMOSI => iMOSI,

            -- i2c
            iSda => sIO_odata(0),
            oSda_e => sIO_en(0),
            oSda => sIO_idata(0),
            iScl => sIO_odata(1),
            oScl_e => sIO_en(1),
            oScl => sIO_idata(1),
--            LED => LED,
        -- SSM2603
            -- i2s: 2 channels sampled @ BCLK
--            oBclk => oBclk,
            -- playback channel
--            oPbdat => oPbdat,
--            oPblrc => oPblrc,
            -- record channel
--            oRecdat => oRecdat,
--            oReclrc => oReclrc,

            -- audio control i2c
            oSclk => oSclk,
            iSdin => sIO_odata(2),
            oSdin_e => sIO_en(2),
            oSdin => sIO_idata(2),

            -- misc/system
            oMute => oMute,
            oMclk => oMclk
        );

    glue: zybo_glue
        port map (
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

            ioIO_pins(0) => open,--ioSDA,
            ioIO_pins(1) => open,--ioSCL,
            ioIO_pins(2) => ioSDIN
        );
       
--        cnt: counter
--        port map(
--            cout => count_sig,  -- core
--            clk => sClk_core,
--            reset => '1'
--        );
--        LED <= count_sig(23);
--        LED_Reset <= sReset_core;
       
end v1;