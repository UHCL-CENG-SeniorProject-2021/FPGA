library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- SSM2603 Codec on the zybo
-- Rec Mono (One Channel) Fs=48Khz, BCLK = 1.152MHz (48000Hz * 24bits = 1.152Mhz)

-- BCLK >= Sampling_Rate * Word_Length * 2 = 48kHz * 24bits * 2 = 2.304Mhz)

entity i2s_basic is
    generic(
        width: integer := 24 -- Channel width
        );
    Port ( 
    -- global signals    
        iClk_core: in std_logic;        -- system clock
        iReset_core: in std_logic;      -- system reset
    -- SSM2603
        -- i2s: 2 channels sampled @ BCLK
        oBclk: out std_logic;           -- i2s serial clock
        -- playback channel
        oPbdat: out std_logic;          -- i2s playback data
        oPblrc: out std_logic;          -- i2s playback L/R CLK
        -- record channel
        iRecdat: in std_logic;          -- i2s recorded data
        oReclrc: out std_logic;         -- i2s rec L/R CLK
        -- misc/system
        oMclk: out std_logic;           -- 12.288MHz (per RM)
        oMute: out std_logic;    -- digital enable (active low)
        done: out std_logic;
        d_out: out std_logic_vector(width-1 downto 0)
  );
end i2s_basic;

architecture Behavioral of i2s_basic is
	--signals 
	signal sBclk: std_logic;                       -- bit serial clk
	signal sMclk: std_logic;                       -- master clk
	signal CLKcount: integer range 0 to 55 := 0;   -- clk count&div 125MHz/2.304MHz = 54.253
	signal CLKcnt: integer range 0 to 6 := 0;      -- clk count&div 125MHz/12.288MHz = 10.17 
	signal b_cnt: integer range 0 to width := 0;       -- received bit counter
	signal b_reg: std_logic_vector (width-1 downto 0); -- received data vector

begin
    Freq_Divider_BCLK: process(iClk_core, iReset_core) begin
        if (iReset_core = '1') then          -- reset state
            sBclk <= '0';
			CLKcount <= 0;
		elsif rising_edge(iClk_core) then    -- on rising edge of sys clk
        -- supposed to be 54 but that generates 1.136MHz
			if (CLKcount = 53) then          -- if CLKcount == 53 (54?)         
				sBclk <= not(sBclk);         -- reset clock
				CLKcount <= 0;               -- reset count
			else
				CLKcount <= CLKcount + 1;    -- otherweise, increment count
			end if;
		end if;
	end process;
	
	Freq_Divider_MCLK: process(iClk_core, iReset_core) begin
		if (iReset_core = '1') then		     -- reset state
			sMclk <= '0';
			CLKcnt <= 0;
		elsif rising_edge(iClk_core) then    -- on rising edge of sys clk
		-- supposed to be 5 but that generates 10.416MHz
			if (CLKcnt = 4) then             -- if CLKcnt == 4 (5?)
				sMclk <= not(sMclk);         -- reset clock
				CLKcnt <= 0;                 -- reset count
			else
				CLKcnt <= CLKcnt + 1;        -- otherwise, increment count
			end if;
		end if;
	end process;
	
	Data_ret: process(sBclk, iReset_core) begin
		if (iReset_core = '1') then       -- reset state
		elsif rising_edge(sBclk) then                             -- on Bclk rising edge
			if (b_cnt = width-1) then                             -- if count == channel width
				b_reg <= b_reg(width - 2 downto 0) & iRecdat;     -- send rec data to b_reg
				b_cnt <= 0;                                       -- reset count
				done <= '1';                                      -- done == 1
			else                                                  -- otherwise,
				b_reg <= b_reg(width - 2 downto 0) & iRecdat;     -- send rec data to b_reg
				b_cnt <= b_cnt + 1;                               -- increment count
				done <= '0';                                      -- done == 0
			end if;
		end if;
	end process;

	oBclk <= sBclk;
	oMclk <= sMclk;
	oReclrc <= '0';
	oMute <= '1';
	d_out <= b_reg;
	
end Behavioral;

