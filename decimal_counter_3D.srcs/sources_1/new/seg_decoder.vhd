library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seg_decoder is
    Port ( hex : in INTEGER RANGE 0 to 9;
--           enableN : in STD_LOGIC_VECTOR (4 downto 1);
           seg : out STD_LOGIC_VECTOR (6 downto 0)
          -- dec_anode : out STD_LOGIC_VECTOR (2 downto 0));
          );
end seg_decoder;

architecture Behavioral of seg_decoder is
begin

process(hex)--, enableN)
begin
--    case enableN is
--        when "1110" =>
--            dec_anode <= "110";
--        when "1101" =>
--            dec_anode <= "101";
--        when "1011" =>
--            dec_anode <= "011";
--        when others =>
--            dec_anode <= "111";
--    end case;

    case hex is
        when 0 =>
            seg <= "0000001";
        when 1 =>
            seg <= "1001111";
        when 2 =>
            seg <= "0010010";
        when 3 =>
            seg <= "0000110";
        when 4 =>
            seg <= "1001100";
        when 5 =>
            seg <= "0100100";
        when 6 =>
            seg <= "0100000";
        when 7 =>
            seg <= "0001111";
        when 8 =>
            seg <= "0000000";
        when 9 =>
            seg <= "0000100";
        when others =>
            seg <= (others =>'1');        
    end case;
    
end process;
end Behavioral;
