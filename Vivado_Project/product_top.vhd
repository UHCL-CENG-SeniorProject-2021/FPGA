library ieee;
use ieee.std_logic_1164.all;

entity product_top is

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
        oBclk: out std_logic; -- i2s clock
        -- playback channel
        oPbdat: out std_logic; -- i2s playback data
        oPblrc: out std_logic; -- i2s playback left-right signal
        -- record channel
        iRecdat: in std_logic; -- i2s recorded data
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

    constant cW: natural := 24;          -- max width of audio data sample vector
    constant cTest: boolean := true;

    component grlib_tester is
    port (
        iClk: in std_logic;
        iReset: in std_logic;

        -- UART
        iRs: in std_logic;
        oRs: out std_logic;

         --SPI
        iSck: in std_logic;
        iCsn: in std_logic;
        iMosi: in std_logic;
        oMiso: out std_logic;

        -- Debug UART
        iRs_dbg: in std_logic;
        oRs_dbg: out std_logic;

        iGPIO: in std_logic_vector (8 downto 0);
        oGPIO: out std_logic
    );
end component;
    
    component logic_top
        port (
            iClk: in std_logic;        -- was iClk_core, changed to iClk
            iReset: in std_logic;

            -- uart
            iUart_dbg: in std_logic;
            oUart_dbg: out std_logic;

            -- spi
            iSck: in std_logic;
            iCsn: in std_logic;
            oMiso: out std_logic;
            iMosi: in std_logic;

            iRs: in std_logic;
            -- i2c
--            iSda: in std_logic;
--            oSda_e: out std_logic;
--            oSda: out std_logic;
--            iScl: in std_logic;
--            oScl_e: out std_logic;
--            oScl: out std_logic;

        -- SSM2603 (audio chip on zybo)
            -- audio control i2c
            oSclk: out std_logic;
            iSdin: in std_logic;
            oSdin_e: out std_logic;
            oSdin: out std_logic;

            -- misc/system
            iGPIO: in std_logic_vector (8 downto 0);
            oGPIO: out std_logic
        -- internals
--            iNd: in std_logic;
--            iData: in std_logic_vector (cW-1 downto 0);
--            oAck: out std_logic;

--            oNd: out std_logic;
--            oData: out std_logic_vector (cW-1 downto 0);
--            iAck: in std_logic
        );
    end component;

    component i2s_ctrl
        port (
            iClk_core: in std_logic;
            iReset_core: in std_logic;
            iClk_i2s: in std_logic;
            iReset_i2s: in std_logic;

        -- internals
            iNd: in std_logic;
            iData: in std_logic_vector (cW-1 downto 0);
            oAck: out std_logic;

            oNd: out std_logic;
            oData: out std_logic_vector (cW-1 downto 0);
            iAck: in std_logic;

        -- SSM2603
             -- i2s: 2 channels sampled @ BCLK
            oBclk: out std_logic;   -- digital I/O -- Digital Audio Bit Clock
            -- playback channel
            oPbdat: out std_logic;  -- i2s playback data -- R18
            oPblrc: out std_logic;  -- i2s playback L/R signal
            -- record channel
            iRecdat: in std_logic; -- i2s recorded data
            oReclrc: out std_logic; -- i2s rec L/R signal

            -- misc/system
            oMclk: out std_logic;
            oMute: out std_logic
       );
    end component;
    
----------------------------------Signals----------------------------------
    signal sNd_tx: std_logic;                           -- ?
    signal sNd_rx: std_logic;                           -- ??
    signal sData_tx: std_logic_vector (cW-1 downto 0);  -- data transfer
    signal sData_rx: std_logic_vector (cW-1 downto 0);  -- data receive
    signal sAck_tx: std_logic;                          -- acknowledge transfer
    signal sAck_rx: std_logic;                          -- acknowledge receive
---------------------------------------------------------------------------

begin
    i2s_ctrl_inst: i2s_ctrl
        port map (
            iClk_core => iClk_core,
            iReset_core => iReset_core,
            iClk_i2s => iClk_i2s,
            iReset_i2s => iReset_i2s,
    
        -- internals
            iNd => sNd_rx,
            iData => sData_rx,
            oAck => sAck_rx,
            oNd => sNd_tx,
            oData => sData_tx,
            iAck => sAck_tx,
    
        -- SSM2603
            -- i2s: 2 channels sampled @ BCLK
            oBclk => oBclk,
            -- playback channel
            oPbdat => oPbdat,
            oPblrc => oPblrc,
            -- record channel
            iRecdat => iRecdat,
            oReclrc => oReclrc,
            -- misc/system
            oMclk => oMclk,
            oMute => oMute
    );

end v1;
