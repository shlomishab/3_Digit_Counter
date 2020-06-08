library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shiftRegister is
    Port ( clk_500, rst : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (2 downto 0));
end shiftRegister;

architecture Behavioral of shiftRegister is

signal temp : unsigned (2 downto 0) := "110";
signal ready_rot : STD_LOGIC := '1';

begin
process(clk_500)
begin
    if rising_edge(clk_500) then
        if rst = '1' and ready_rot = '1' then
            temp <= "110";
        else
            temp <= ROTATE_LEFT(temp, 1);
        end if;
    end if;
end process;

process(clk_500)
begin
    if rising_edge(clk_500) then
	   if rst = '1' then 
	       ready_rot <= '0';
	   else
	       ready_rot <= '1';
	   end if;
	end if;	
end process;

output <= STD_LOGIC_VECTOR(temp); 

end Behavioral;
