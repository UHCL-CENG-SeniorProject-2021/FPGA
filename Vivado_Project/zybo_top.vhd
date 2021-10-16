library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zybo_top is
    port (
        -- System Clock
        iClk: in std_logic;
        
        -- UART
        iUART: in std_logic;        -- Rx
        oUART: out std_logic;       -- Tx
        -- I2C
--        ioSDA: inout std_logic;     -- I/O data
        
-- SSM2603 (addr: 0011010b)        
        -- I2C (config)
        oSCLK: inout std_logic;       -- I/O clock
        ioSDIN: inout std_logic;    -- Audio Codec config (N17)
        
        -- I2S
--        oBCLK: out std_logic;       -- i2s clock
        -- playback channel
--        oPBDAT: out std_logic;      -- playback data
--        oPBLRC: out std_logic;      -- L/R playback clock
        -- record channel
--        oRECDAT: out std_logic;     -- i2s recorded data
--        oRECLRC: out std_logic;     -- L/R recorded clock
        -- misc/system
--        oMUTE: out std_logic;
--        oMCLK: out std_logic;

        -- GPIO
        LED: out std_logic;
        -- SPI
        iSck: in std_logic;
        iCsn: in std_logic;
        oMiso: out std_logic;
        iMosi: in std_logic
    );
end zybo_top;

architecture Behavioral of zybo_top is

    constant cIO_n: natural := 3; -- number of inout pins

    signal sIO_idata: std_logic_vector (cIO_n-1 downto 0);
    signal sIO_en: std_logic_vector (cIO_n-1 downto 0);
    signal sIO_odata: std_logic_vector (cIO_n-1 downto 0);

    signal sClk_core: std_logic;
    signal sReset_core: std_logic;
    signal sClk_i2s: std_logic;                 -- codec clock
    
    signal sReset_i2s: std_logic;

 component product_top
        port (
    -- System signals
        iClk_core: in std_logic;
        iReset_core: in std_logic;
        iClk_i2s: in std_logic;
        iReset_i2s: in std_logic;

    -- RPI COMMS
        -- UART
        iUart: in std_logic;
        oUart: out std_logic;

    -- SSM2603
--        -- I2S: 2 channels sampled @ BCLK
--        oBclk: out std_logic;       -- i2s clock
--        -- playback channel
--        oPbdat: out std_logic;      -- i2s playback data
--        oPblrc: out std_logic;      -- L/R playback clock
--        -- record channel
--        oRecdat: out std_logic;     -- i2s recorded data
--        oReclrc: out std_logic;     -- L/R recorded clock

        -- audio control i2c
        iSclk: in std_logic;
        oSclk: out std_logic;
        oSclk_e: out std_logic;
        iSdin: in std_logic;
        oSdin_e: out std_logic;
        oSdin: out std_logic;

        -- misc/system
        oMute: out std_logic;
        oMclk: out std_logic;
        
        -- LED
        LED: out std_logic;
        
        -- SPI
        iSck: in std_logic;
        iCsn: in std_logic;
        oMiso: out std_logic;
        iMosi: in std_logic

--        -- I2C
--        iSda: in std_logic;
--        iScl: in std_logic;
--        oSda_e: out std_logic;
--        oSda: out std_logic;
--        oScl_e: out std_logic;
--        oScl: out std_logic
        -- GPIO
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

begin
        
    top: product_top
        port map (
        -- system signals
            iClk_core => sClk_core,
            iReset_core  => sReset_core,
            iClk_i2s => sClk_i2s,
            iReset_i2s  => sReset_i2s,

            -- RPI COMMS
            -- UART
            iUart => iUart,
            oUart => oUart,
            
-- SSM2603
        -- I2S: 2 channels sampled @ BCLK
--            oBclk => oBclk,
            -- playback channel
--            oPbdat => oPbdat,
--            oPblrc => oPblrc,
            -- record channel
--            oRecdat => oRecdat,
--            oReclrc => oReclrc,

            -- audio control i2c
            iSdin => sIO_odata(0),
            oSdin_e => sIO_en(0),
            oSdin => sIO_idata(0),
            iSclk => sIO_odata(1),
            oSclk_e => sIO_en(1),
            oSclk => sIO_idata(1),
--            iSdin => sIO_odata(2),
--            oSdin_e => sIO_en(2),
--            oSdin => sIO_idata(2)

            -- misc/system
--            oMute => oMute,
--            oMclk => oMclk

        -- SPI
            iSck => iSck,
            iCsn => iCsn,
            oMiSO => oMiSO,
            iMOSI => iMOSI,
            
            LED => LED
        );

    glue: zybo_glue
        port map (
            -- clocks/resets
            iCLK => iCLK,
            oClk_core => sClk_core,
            oReset_core => sReset_core,
            oClk_i2s => sClk_i2s,
            oReset_i2s => sReset_i2s,

            -- IO buffers
            iIO_data => sIO_idata,
            iIO_en => sIO_en,
            oIO_data => sIO_odata,
            ioIO_pins(0) => ioSDIN,
            ioIO_pins(1) => oSCLK
--            ioIO_pins(2) => ioSDIN
        );

end Behavioral;
