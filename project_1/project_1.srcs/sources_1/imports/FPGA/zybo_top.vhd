-- this wrapper file defines zybo physical interfacing level

library ieee;
use ieee.std_logic_1164.all;


entity zybo_top is
    port (
--------------------------------------------
-- system signals
        iCLK: in std_logic;
        iRESET: in std_logic;

--------------------------------------------
-- rpi comms

        -- uart
        iUART: in std_logic;
        oUART: out std_logic;

        -- spi
        iSCK: in std_logic;
        iCSN: in std_logic;
        oMOSI: out std_logic;
        iMISO: in std_logic;

        -- i2c
        ioSDA: inout std_logic;
        ioSCL: inout std_logic;

--------------------------------------------
-- SSM2603
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
        oMCLK: out std_logic
    );
    -- TODO: define pinout (1st task)
    attribute loc: string;
    attribute loc of iCLK: signal is "K17";
    attribute loc of iUART: signal is "DEFINE ME";
    attribute loc of oUART: signal is "DEFINE ME";
    attribute loc of iSCK: signal is "DEFINE ME";
    attribute loc of iCSN: signal is "DEFINE ME";
    attribute loc of oMOSI: signal is "DEFINE ME";
    attribute loc of iMISO: signal is "DEFINE ME";
    attribute loc of ioSDA: signal is "DEFINE ME";
    attribute loc of ioSCL: signal is "DEFINE ME";
    attribute loc of oBCLK: signal is "K18";
    attribute loc of oPBDAT: signal is "M17";
    attribute loc of oPBLRC: signal is "L17";
    attribute loc of oRECDAT: signal is "K17";
    attribute loc of oRECLRC: signal is "M18";
    attribute loc of ioSDIN: signal is "N17";
    attribute loc of oSCLK: signal is "N18";
    attribute loc of oMUTE: signal is "P18";
    attribute loc of oMCLK: signal is "T19";
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
            oMosi: out std_logic;
            iMiso: in std_logic;

            -- i2c
            iSda: in std_logic;
            oSda_e: out std_logic;
            oSda: out std_logic;
            iScl: in std_logic;
            oScl_e: out std_logic;
            oScl: out std_logic;

        -- SSM2603
            -- i2s: 2 channels sampled @ BCLK
            oBclk: out std_logic; -- i2s clock
            -- playback channel
            oPbdat: out std_logic; -- i2s playback data
            oPblrc: out std_logic; -- i2s playback left-right signal
            -- record channel
            oRecdat: out std_logic; -- i2s recorded data
            oReclrc: out std_logic; -- i2s rec left-right signal

            -- audio control i2c
            oSclk: out std_logic;
            iSdin: in std_logic;
            oSdin_e: out std_logic;
            oSdin: out std_logic;

            -- misc/system
            oMute: out std_logic;
            oMclk: out std_logic
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
            oMosi => oMosi,
            iMiso => iMiso,

            -- i2c
            iSda => sIO_odata(0),
            oSda_e => sIO_en(0),
            oSda => sIO_idata(0),
            iScl => sIO_odata(1),
            oScl_e => sIO_en(1),
            oScl => sIO_idata(1),

        -- SSM2603
            -- i2s: 2 channels sampled @ BCLK
            oBclk => oBclk,
            -- playback channel
            oPbdat => oPbdat,
            oPblrc => oPblrc,
            -- record channel
            oRecdat => oRecdat,
            oReclrc => oReclrc,

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

            ioIO_pins(0) => ioSDA,
            ioIO_pins(1) => ioSCL,
            ioIO_pins(2) => ioSDIN
        );

end v1;
