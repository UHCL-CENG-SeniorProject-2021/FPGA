library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_top is
    port (
        iClk: in std_logic;

        -- UART
        iRs: in std_logic;
        oRs: out std_logic;

        oGPIO: out std_logic
    );
end test_top;

architecture Behavioral of test_top is

constant test_UART: boolean := false;

component logic_top is
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

begin
test_GRLIB: if(not test_UART)
    generate begin
tester: logic_top port map(
    iClk=>iClk, 
    iReset => '1',
    iRs_dbg=>iRs,
    oRs_dbg=>oRs,
    oGPIO=>oGPIO,
    iRs=>'1',
    iSck=>'1',
    iCsn=>'1',
    iGPIO=>(others=>'0'),
    iMosi=>'1'    
    ); end generate;
    
    UART_test: if(test_UART)
        generate begin
        oRs<=iRs;
        oGPIO<='1';
        end generate;
end Behavioral;
