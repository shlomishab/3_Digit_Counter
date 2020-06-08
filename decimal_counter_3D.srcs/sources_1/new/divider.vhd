
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity divider is
    Port ( clk_div_100M, rst : in STD_LOGIC;
           clk_5, clk_500 : out STD_LOGIC);
end divider;

architecture Behavioral of divider is
signal count_5, count_500 : integer := 0;
signal ready_rst : std_logic := '1';
signal temp_5, temp_500 : std_logic;
constant c5 : integer:=10000000;
constant c500 : integer:=100000;

constant c5_tb : integer:=100;
constant c500_tb : integer:=10;
begin

	process(clk_div_100M)
	begin
		if rising_edge(clk_div_100M) then
			if rst = '1' then 
				ready_rst <= '0';
			else
				ready_rst <= '1';
			end if;
		end if;	
	end process;
	
	
	process(clk_div_100M)
	variable var_5, var_500 : std_logic;
	begin
		if rising_edge (clk_div_100M) then
			if rst = '1' and ready_rst = '1' then
				count_5 <= 0;
				count_500 <= 0;
				var_5 := '0';
				var_500 := '0';
			else
				count_5 <= count_5 + 1;
				count_500 <= count_500 + 1;
            
				if(count_5 = c5) then -- 10000000
					var_5 := not var_5;
					count_5 <= 0;
				end if;
				if(count_500 = c500) then --100000
					var_500 := not var_500;
					count_500 <= 0;
				end if;
			end if;
		end if;
    clk_5 <= var_5;
    clk_500 <= var_500;
	end process;
end Behavioral;
