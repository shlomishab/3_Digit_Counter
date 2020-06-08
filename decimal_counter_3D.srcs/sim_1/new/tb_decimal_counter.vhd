library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_decimal_counter is
--  Port ( );
end tb_decimal_counter;

architecture Behavioral of tb_decimal_counter is
component decimal_counter_3D is
    Port ( reset, clk_100M : in STD_LOGIC;
           top_count : in STD_LOGIC_VECTOR (3 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (6 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC);
end component;

signal clk_100M :  STD_LOGIC := '0';
signal reset :  STD_LOGIC;
signal  top_count :  STD_LOGIC_VECTOR (3 downto 0);
signal seven_seg :  STD_LOGIC_VECTOR (6 downto 0);
signal anode :  STD_LOGIC_VECTOR (3 downto 0);
signal led :  STD_LOGIC;

begin

U1: decimal_counter_3D port map(clk_100M=>clk_100M,reset=>reset,top_count=>top_count,
                                seven_seg=>seven_seg,anode=>anode,led=>led);

clk_100M <= not clk_100M after 10ps;

process
begin
    reset <= '1';
    top_count <= "0111";
    wait for 1ns;
    reset <= '0';
--    wait for 1130ns;
--    reset <= '1';
--    wait for 1500ns;
--    reset <= '0';
    wait;
end process;


end Behavioral;
