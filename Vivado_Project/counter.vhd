library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
  Port (
    cout   :out std_logic_vector (23 downto 0);
    clk    :in  std_logic;
    reset  :in  std_logic
  );
end counter;

architecture Behavioral of counter is

signal count : unsigned(23 downto 0);

begin
    process (clk) begin
    if (rising_edge(clk)) then
        if (reset = '0') then
            count <= (others=>'0');
                else
                    count <= count + 1;
        end if;
    end if;
    end process;
   
    cout <= std_logic_vector(count);
   
end Behavioral;