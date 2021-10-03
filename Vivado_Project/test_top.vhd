library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_top is
    port (
        iCLK: in std_logic;

        -- UART
        iUART: in std_logic;
        oUART: out std_logic;
        
        oGPIO: out std_logic
    );
end test_top;

architecture Behavioral of test_top is

constant test_UART: boolean := true;

component logic_top is
    port (
        iCLK: in std_logic;
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

begin
test_GRLIB: if(not test_UART)
    generate begin
tester: logic_top port map(
    iCLK=>iCLK, 
    iReset => '1',
    iUART_dbg=>iUART,
    oUART_dbg=>oUART,
    oGPIO=>oGPIO,
    iUART=>'1',
    iSck=>'1',
    iCsn=>'1',
    iGPIO=>(others=>'0'),
    iMosi=>'1'
    ); end generate;

    UART_test: if(test_UART)
        generate begin
        oUART<=iUART;
        oGPIO<='1';
        end generate;
end Behavioral;