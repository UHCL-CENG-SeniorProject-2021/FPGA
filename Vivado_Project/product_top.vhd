library ieee;
use ieee.std_logic_1164.all;

entity product_top is
    Port (
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
        oMclk: out std_logic;
        
        -- LED
        LED: out std_logic
    );
end entity;

architecture v1 of product_top is

    -- TODO: define valid value
    -- max width of audio data sample vector
    constant cW: natural := 24;

component logic_top is
    port (
        iClk: in std_logic;
        iReset: in std_logic;

        -- UART
        iUART: in std_logic;
        oUART: out std_logic;

         --SPI
        iSck: in std_logic;
        iCsn: in std_logic;
        iMosi: in std_logic;
        oMiso: out std_logic;

        -- Debug UART
        iUART_dbg: in std_logic;
        oUART_dbg: out std_logic;

        iGPIO: in std_logic_vector (8 downto 0);
        oGPIO: out std_logic
    );
end component;

--    component i2s_ctrl
--        port (
--            iClk_core: in std_logic;
--            iReset_core: in std_logic;
--            iClk_i2s: in std_logic;
--            iReset_i2s: in std_logic;

--        -- internals
--            iNd: in std_logic;
--            iData: in std_logic_vector (cW-1 downto 0);
--            oAck: out std_logic;

--            oNd: out std_logic;
--            oData: out std_logic_vector (cW-1 downto 0);
--            iAck: in std_logic;

--        -- SSM2603
--             -- i2s: 2 channels sampled @ BCLK
--            oBclk: out std_logic; -- i2s clock
--            -- playback channel
--            oPbdat: out std_logic; -- i2s playback data
--            oPblrc: out std_logic; -- i2s playback left-right signal
--            -- record channel
--            oRecdat: out std_logic; -- i2s recorded data
--            oReclrc: out std_logic; -- i2s rec left-right signal

--            -- misc/system
--            oMclk: out std_logic
--       );
--    end component;

    signal sNd_tx: std_logic;
    signal sData_tx: std_logic_vector (cW-1 downto 0);
    signal sAck_tx: std_logic;
    signal sNd_rx: std_logic;
    signal sData_rx: std_logic_vector (cW-1 downto 0);
    signal sAck_rx: std_logic;

begin

       tester: logic_top port map(
        iClk => iClk_core, 
        iReset => '1',
        iUART_dbg => iUART,
        oUART_dbg => oUART,
        oGPIO => LED,
        iUART => '1',
        iSck => '1',
        iCsn => '1',
        iGPIO => (others=>'0'),
        iMosi => '1'    
        );        
        
--    i2s_ctrl_inst: i2s_ctrl
--        port map (
--            iClk_core => iClk_core,
--            iReset_core => iReset_core,
--            iClk_i2s => iClk_i2s,
--            iReset_i2s => iReset_i2s,

--        -- internals
--            iNd => sNd_rx,
--            iData => sData_rx,
--            oAck => sAck_rx,

--            oNd => sNd_tx,
--            oData => sData_tx,
--            iAck => sAck_tx,

--        -- SSM2603
--             -- i2s: 2 channels sampled @ BCLK
--            oBclk => oBclk,
--            -- playback channel
--            oPbdat => oPbdat,
--            oPblrc => oPblrc,
--            -- record channel
--            oRecdat => oRecdat,
--            oReclrc => oReclrc,

--            -- misc/system
--            oMclk => oMclk
--       );

end v1;