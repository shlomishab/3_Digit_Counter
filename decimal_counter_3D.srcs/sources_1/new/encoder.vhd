
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity encoder is
    Port ( input_anode : in STD_LOGIC_VECTOR (2 downto 0);
           output_sel : out STD_LOGIC_VECTOR (1 downto 0));
end encoder;

architecture Behavioral of encoder is

begin
process(input_anode)
begin
    case input_anode is
        when "110" =>
            output_sel <= "00";
        when "101" =>
            output_sel <= "01";
        when "011" => 
            output_sel <= "10";
        when others =>
            output_sel <= "11";
    end case;
end process;  
      
end Behavioral;
