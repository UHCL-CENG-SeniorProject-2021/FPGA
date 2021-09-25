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

entity logic_top is
    port (
        iClk: in std_logic;
        iReset: in std_logic;

        -- UART
        iRs: in std_logic;
        oRs: out std_logic;

        -- Debug UART
        iUart_dbg: in std_logic;
        oUart_dbg: out std_logic;
        
        -- SPI (https://gaisler.com/products/grlib/grip.pdf, page 1713)
        -- In some systems with only one master and one slave, the Slave Select input of the slave may 
        -- be always active and the master does not need to have a slave select output. This does not 
        -- apply to this SPI to AHB bridge, the slave select signal must be used to mark the start and
        -- end of an operation.
        iSck: in std_logic;     -- serial clock
        iCsn: in std_logic;     -- chip/slave select
        iMosi: in std_logic;    -- Master Out, Slave In
        oMiso: out std_logic;   -- Master in, Slave Out
        
        -- General Purpose I/O
        iGPIO: in std_logic_vector (8 downto 0);
        oGPIO: out std_logic
    );
end logic_top;

architecture logic_top_arc of logic_top is

    ----------------- AMBA constants
    constant cAHB_def_master: integer := 0;
    constant cAPBCTRL_AHB_addr: integer := 16#800#;
    constant cAPBCTRL_AHB_mask: integer := 16#f00#;

    ----------- AMBA AHB Masters Indeces
    constant cINDEX_AHBM_UART_DBG: integer := 0;

    constant cINDEX_AHBM_SPI: integer := 1;
    constant cAHB_mst_num: integer := 2;    -- no. of AHB masters on the bus (UART, SPI)


    ---------------- AMBA AHB Slaves Indeces
    constant cINDEX_AHBS_APBCTRL: integer := 0;
    constant cAHB_slv_num: integer := 1;

    ------------------ AMBA APB Indeces
    constant cINDEX_APB_GPIO: integer := 0;
    constant cINDEX_APB_APBUART: integer := 1;
    constant cINDEX_APB_SPI: integer := 2;
    constant cINDEX_APB_UART_DBG: integer := 3;
    constant cAPB_slv_num: integer := 4;

    constant cGPIO_width: integer := 10;

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

begin

    sUARTi.rxd <= iRs;
    sUARTi.extclk <= '0';
    sUARTi.ctsn <= '1';
    oRs <= sUARTo.txd;

    sSPIi.sck <= iSck;
    sSPIi.spisel <= iCsn;
    sSPIi.mosi <= iMosi;
    oMiso <= sSPIo.miso;

    sUART_dbg_i.rxd <= iUart_dbg;
    oUart_dbg <= sUART_dbg_o.txd;

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
<<<<<<< Updated upstream
            pindex => cINDEX_APB_SPI,
            paddr => cINDEX_APB_SPI
        )
        port map (
            rstn => sReset_synch,
            clk => iClk,
            apbi => sAPBi,
            apbo => sAPBo(cINDEX_APB_SPI),
=======
   -- AHB Configuration
        -- AHB master index (allowed range 0 - NAHBMST)     
        hindex => cINDEX_AHBM_SPI,
        -- ahb address hi/lo (can restrict access to memory)
        ahbaddrh => 0,  -- bits 31:16 of addr used for mem protection area (0-16#FFF#)
        ahbaddrl => 0,  -- bits 15:0
        -- ahb mask hi/lo
        ahbmaskh => 0,  -- bits 31:16 of mask used for mem protection area (0-16#FFF#)
        ahbmaskl => 0,  -- bits 15:0 ...
        -- TODO: which enable pin sets tri-state iobuf (zybo)
        oepol => 0,     -- Output enable polatiry (2-512, default 2) check active level / polarity
        -- Rpi should start with lower speeds (lower than 100kHz)
        filter => 2,    -- filters noise, set high and adjust accordingly (decrease) [random guess: set to quarter of SPI freq]
        -- polarity of spi signal, should be same for fpga and pi
        -- if we start to lose samples, check here to fix (may interfere with FIFO)
        -- The combined values of clock polarity (CPOL) and clock phase (CPHA) determine the mode of the SPI bus.
        cpol => 0,      -- Clock polarity of SPI clock (SCK) (range: 0-1, default: 0)
        cpha => 1       -- Clock phase of SPI comms (range: 0-1, default 0) [review wiki pic]
        )
        port map(
            rstn => sReset_synch,
            clk => iClk,
            -- AHB master interface
            ahbi => sAHBmi,
            ahbo => sAHBmo(cINDEX_AHBM_SPI),
            -- SPI signals
>>>>>>> Stashed changes
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

end logic_top_arc;
