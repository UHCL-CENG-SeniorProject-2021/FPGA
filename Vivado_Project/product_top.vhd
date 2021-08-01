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
end entity;

architecture v1 of product_top is

    -- TODO: define valid value
    -- max width of audio data sample vector
    constant cW: natural := 1;

    component logic_top
        port (
            iClk: in std_logic;        -- was iClk_core, changed to iClk 
            iReset: in std_logic;

            -- uart
            iUart: in std_logic;
            oUart: out std_logic;

            -- spi
            iSck: in std_logic;
            iCsn: in std_logic;
            iMiso: in std_logic;
            oMosi: out std_logic;

            -- i2c
            iSda: in std_logic;
            oSda_e: out std_logic;
            oSda: out std_logic;
            iScl: in std_logic;
            oScl_e: out std_logic;
            oScl: out std_logic;

        -- SSM2603 (audio chip on zybo)
            -- audio control i2c
            oSclk: out std_logic;
            iSdin: in std_logic;
            oSdin_e: out std_logic;
            oSdin: out std_logic;

            -- misc/system
            oMute: out std_logic;

        -- internals
            iNd: in std_logic;
            iData: in std_logic_vector (cW-1 downto 0);
            oAck: out std_logic;

            oNd: out std_logic;
            oData: out std_logic_vector (cW-1 downto 0);
            iAck: in std_logic
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
            oBclk: out std_logic; -- i2s clock
            -- playback channel
            oPbdat: out std_logic; -- i2s playback data
            oPblrc: out std_logic; -- i2s playback left-right signal
            -- record channel
            oRecdat: out std_logic; -- i2s recorded data
            oReclrc: out std_logic; -- i2s rec left-right signal

            -- misc/system
            oMclk: out std_logic
       );
    end component;

    signal sNd_tx: std_logic;
    signal sData_tx: std_logic_vector (cW-1 downto 0);
    signal sAck_tx: std_logic;
    signal sNd_rx: std_logic;
    signal sData_rx: std_logic_vector (cW-1 downto 0);
    signal sAck_rx: std_logic;

begin

    ctrl: logic_top
        port map (
            iClk => iClk_core,
            iReset => iReset_core,

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
            iSda => iSda,
            oSda_e => oSda_e,
            oSda => oSda,
            iScl => iScl,
            oScl_e => oScl_e,
            oScl => oScl,

        -- SSM2603
            -- audio control i2c
            oSclk => oSclk,
            iSdin => iSdin,
            oSdin_e => oSdin_e,
            oSdin => oSdin,

            -- misc/system
            oMute => oMute,

        -- internals
            iNd => sNd_tx,
            iData => sData_tx,
            oAck => sAck_tx,

            oNd => sNd_rx,
            oData => sData_rx,
            iAck => sAck_rx
        );

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
            oRecdat => oRecdat,
            oReclrc => oReclrc,

            -- misc/system
            oMclk => oMclk
       );

end v1;
