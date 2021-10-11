library ieee;
use ieee.std_logic_1164.all;

library grlib;
use grlib.amba.all;
use grlib.config.all;

library gaisler;
use gaisler.leon3.all;
use gaisler.uart.all;
use gaisler.misc.all;
use gaisler.spi.all;
use gaisler.i2c.all;

library techmap;
use techmap.gencomp.all;

entity logic_top is
    port (
        -- Clocks
        iClk: in std_logic;
        iReset: in std_logic;
        
        -- UART
        iUART: in std_logic;
        oUART: out std_logic;

        -- Debug UART
        iUart_dbg: in std_logic;
        oUart_dbg: out std_logic;
        
         --SPI
        iSck: in std_logic;
        iCsn: in std_logic;
        iMosi: in std_logic;
        oMiso: out std_logic;
        
        -- I2C
        iSclk: in std_logic;
        oSclk: out std_logic;
        oSclk_e: out std_logic;
        
        iSdin: in std_logic;
        oSdin_e: out std_logic;
        oSdin: out std_logic;

        iGPIO: in std_logic_vector (8 downto 0);
        oGPIO: out std_logic
    );
end logic_top;

architecture logic_top_arc of logic_top is

    -- AMBA constants
    constant cAHB_def_master:       integer := 0;
    constant cAPBCTRL_AHB_addr:     integer := 16#800#;
    constant cAPBCTRL_AHB_mask:     integer := 16#f00#;

    -- AMBA AHB Masters Indeces
    constant cINDEX_AHBM_UART_DBG:  integer := 0;
    constant cAHB_mst_num:          integer := 1;

    -- AMBA AHB Slaves Indeces
    constant cINDEX_AHBS_APBCTRL:   integer := 0;
    constant cAHB_slv_num:          integer := 1;

    -- AMBA APB Indeces
    constant cINDEX_APB_GPIO:       integer := 0;
    constant cINDEX_APB_APBUART:    integer := 1;
    constant cINDEX_APB_SPI:        integer := 2;
    constant cINDEX_APB_UART_DBG:   integer := 3;
    constant cINDEX_APB_I2C:        integer := 4;
    constant cAPB_slv_num:          integer := 5;

    constant cGPIO_width:           integer := 10;
    
    -- IOPAD
    constant padtech:               integer := 0;                                      

    signal sReset_synch: std_logic;

    signal sAHBmi: ahb_mst_in_type;
    signal sAHBmo: ahb_mst_out_vector := (others => ahbm_none);

    signal sAHBsi: ahb_slv_in_type;
    signal sAHBso: ahb_slv_out_vector := (others => ahbs_none);

    signal sAPBi: apb_slv_in_type;
    signal sAPBo: apb_slv_out_vector := (others => apb_none);

    signal sSPIi: spi_in_type;
    signal sSPIo: spi_out_type;

    signal sUARTi: uart_in_type;
    signal sUARTo: uart_out_type;

    signal sUART_dbg_i: uart_in_type;
    signal sUART_dbg_o: uart_out_type;

    signal sGPIOi: gpio_in_type;
    signal sGPIOo: gpio_out_type;
    
    signal sI2Ci: i2c_in_type;
    signal sI2Co: i2c_out_type;

begin
    -- APB UART
    sUARTi.rxd <= iUART;
    sUARTi.extclk <= '0';
    sUARTi.ctsn <= '1';
    oUART <= sUARTo.txd;
    
    -- AHB UART
    sUART_dbg_i.rxd <= iUart_dbg;
    oUart_dbg <= sUART_dbg_o.txd;
   
    -- SPI
    sSPIi.sck <= iSck;
    sSPIi.spisel <= iCsn;
    sSPIi.mosi <= iMosi;
    oMiso <= sSPIo.miso;
    
-- I2C
    -- IN record
    sI2Ci.sda <= iSdin;
    sI2Ci.scl <= iSclk;
    -- OUT record
    oSclk <= sI2Co.scl;
    oSclk_e <= sI2Co.scloen;
    oSdin <= sI2Co.sda;
    oSdin_e <= sI2Co.sdaoen;

    sGPIOi.din(8 downto 0) <= iGPIO;
    oGPIO <= sGPIOo.dout(9);

----------------- Common components
    -- Reset synchronizer
    reset_gen: rstgen
        generic map (
            syncrst => 1
        )
        port map (
            rstin => iReset,
            clk => iClk,
            clklock => '1',
            rstout => sReset_synch
        );

----------------- AMBA AHB components
    -- AHB ctrl
    ahb_ctrl: ahbctrl
        generic map (
            defmast=> cAHB_def_master,
            nahbm => cAHB_mst_num,
            nahbs => cAHB_slv_num,
            ioen => 0
        )
        port map (
            rst => sReset_synch,
            clk => iClk,
            msti => sAHBmi,
            msto => sAHBmo,
            slvi => sAHBsi,
            slvo => sAHBso
        );

    -- Debug UART
    dbg_uart: ahbuart
        generic map (
            hindex => cINDEX_AHBM_UART_DBG,
            pindex => cINDEX_APB_UART_DBG,
            paddr => cINDEX_APB_UART_DBG
        )
        port map (
            rst => sReset_synch,
            clk => iClk,
            uarti => sUART_dbg_i,
            uarto => sUART_dbg_o,
            apbi => sAPBi,
            apbo => sAPBo(cINDEX_APB_UART_DBG),
            ahbi => sAHBmi,
            ahbo => sAHBmo(cINDEX_AHBM_UART_DBG)
        );

----------------- AMBA APB components
    -- APB ctrl
    apb_ctrl: apbctrl
        generic map (
            hindex => cINDEX_AHBS_APBCTRL,
            haddr => cAPBCTRL_AHB_addr,
            hmask => cAPBCTRL_AHB_mask
        )
        port map (
            rst => sReset_synch,
            clk => iClk,
            ahbi => sAHBsi,
            ahbo => sAHBso(cINDEX_AHBS_APBCTRL),
            apbi => sAPBi,
            apbo => sAPBo
        );

    -- GPIO
    gpio: grgpio
        generic map (
            pindex => cINDEX_APB_GPIO,
            paddr => cINDEX_APB_GPIO,
            nbits => cGPIO_width
        )
        port map (
            rst => sReset_synch,
            clk => iClk,
            apbi => sAPBi,
            apbo => sAPBo(cINDEX_APB_GPIO),
            gpioi => sGPIOi,
            gpioo => sGPIOo
        );

    -- SPI
    spi: spictrl
        generic map (
            pindex => cINDEX_APB_SPI,
            paddr => cINDEX_APB_SPI
        )
        port map (
            rstn => sReset_synch,
            clk => iClk,
            apbi => sAPBi,
            apbo => sAPBo(cINDEX_APB_SPI),
            spii => sSPIi,
            spio => sSPIo
        );

    -- UART
    uart: apbuart
        generic map (
            pindex => cINDEX_APB_APBUART,
            paddr => cINDEX_APB_APBUART
        )
        port map(
            rst => sReset_synch,
            clk => iClk,
            apbi => sAPBi,
            apbo => sAPBo(cINDEX_APB_APBUART),
            uarti => sUARTi,
            uarto => sUARTo
        );
        
            -- I2C-slave
    i2cslv0 : i2cslv
        generic map (
            pindex => cINDEX_APB_I2C,   -- APB slave index
            paddr => cINDEX_APB_I2C,    -- ADDR field of APB
            pmask => 16#FFF#,           -- MASK field of APB
            pirq => 1,                  -- interrupt by i2c
            hardaddr => 0,              -- 0: slv can change addr 1: cannot change
            tenbit => 1,                -- 0: no 10-bit 1: 10-bit support
            i2caddr => 16#50#           -- slave's initial i2c addr
        )
        port map (
            rstn => sReset_synch,           -- reset
            clk => iClk,                    -- clock
            apbi => sAPBi,                  -- APB slv input
            apbo => sAPBo(cINDEX_APB_I2C),  -- APB slv output;
            i2ci => sI2Ci,                  -- i2c clock input
            i2co => sI2Co                   -- i2c clock output
        );
        
end logic_top_arc;
