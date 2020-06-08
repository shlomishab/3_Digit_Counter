
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux4x1 is
    Port ( I0, I1, I2, I3 : in INTEGER RANGE 0 to 9;
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           output_int : out INTEGER RANGE 0 to 9);
end mux4x1;

architecture Behavioral of mux4x1 is

begin
process(I0, I1, I2, I3, sel)
begin
    case sel is
        when "00" =>
            output_int <= I0;
        when "01" =>
            output_int <= I1;
        when "10" =>
            output_int <= I2;
        when others =>
            output_int <= I3;  
    end case;                      

end process;

end Behavioral;
