library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decimal_counter_3D is
    Port ( reset, clk_100M : in STD_LOGIC;
           top_count : in STD_LOGIC_VECTOR (3 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (6 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC);
end decimal_counter_3D;



architecture Behavioral of decimal_counter_3D is
component counter is
    Port ( clk, en, clr, rst : in STD_LOGIC;
           top_count : in STD_LOGIC_VECTOR (3 downto 0);
           q : buffer INTEGER RANGE 0 to 9;
           top_count_reach, reach_9 : out STD_LOGIC);
end component;
signal q_LSD, q_ISD, q_MSD : INTEGER RANGE 0 to 9;
signal top_L, top_I, top_M : STD_LOGIC;
signal reach_9_L, reach_9_I, reach_9_M : STD_LOGIC;
signal clr_L, clr_I, clr_M : STD_LOGIC;
signal clr_all : STD_LOGIC;  
signal en_I, en_M : STD_LOGIC;

component divider is
    Port ( clk_div_100M, rst : in STD_LOGIC;
           clk_5, clk_500 : out STD_LOGIC);
end component;
signal clk_5, clk_500 :  STD_LOGIC;

component encoder is
    Port ( input_anode : in STD_LOGIC_VECTOR (2 downto 0);
           output_sel : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component mux4x1 is
    Port ( I0, I1, I2, I3 : in INTEGER RANGE 0 to 9;
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           output_int : out INTEGER RANGE 0 to 9);
end component;

component shiftRegister is
    Port ( clk_500, rst : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (2 downto 0));
end component;
signal sig_anode : STD_LOGIC_VECTOR (2 downto 0);
signal sig_sel :  STD_LOGIC_VECTOR (1 downto 0);

component seg_decoder is
    Port ( hex : in INTEGER RANGE 0 to 9;
--           enableN : in STD_LOGIC_VECTOR (4 downto 1);
           seg : out STD_LOGIC_VECTOR (6 downto 0)
           --dec_anode : out STD_LOGIC_VECTOR (2 downto 0));
           );
end component;
signal sig_hex : INTEGER RANGE 0 to 9;
signal sig_led : STD_LOGIC;
begin
anode(2 downto 0) <= sig_anode;
led <= sig_led;
sig_led <= top_L and top_I and top_M;
anode(3) <= '1';

--,top_L,top_I,top_M
process(reach_9_L,reach_9_I,reach_9_M,sig_led)
begin
	case sig_led is
		when '1' => 
			clr_L <= '1';
			clr_I <= '1';
			clr_M <= '1';
		when others =>
            if(reach_9_L = '1') then
                clr_L <= '1';
                en_I <= '1';
                if (reach_9_I = '1') then
                    clr_I <= '1';
                    en_M <= '1';
                    if(reach_9_M = '1') then
                        clr_M <= '1';
                    end if;
                end if;
            else
                clr_L <= '0';
                clr_I <= '0';
                clr_M <= '0';
                en_I <= '0';
                en_M <= '0';
            end if;
    end case;
end process;

LSD: counter port map(clk=>clk_5,en=>'1',clr=>clr_L,rst=>reset,top_count=>top_count,
                      top_count_reach=>top_L,reach_9=>reach_9_L,q=>q_LSD);

ISD: counter port map(clk=>clk_5,en=>en_I,clr=>clr_I,rst=>reset,top_count=>top_count,
                      top_count_reach=>top_I,reach_9=>reach_9_I,q=>q_ISD);

MSD: counter port map(clk=>clk_5,en=>en_M,clr=>clr_M,rst=>reset,top_count=>top_count,
                      top_count_reach=>top_M,reach_9=>reach_9_M,q=>q_MSD);

DIV: divider port map(clk_div_100M=>clk_100M,rst=>reset,
                        clk_5=>clk_5,clk_500=>clk_500);
                        
REG: shiftRegister port map (rst=>reset,clk_500=>clk_500,output=>sig_anode);

ENC: encoder port map(input_anode=>sig_anode,output_sel=>sig_sel);

MUX: mux4x1 port map(I0=>q_LSD,I1=>q_ISD,I2=>q_MSD,I3=>0,
                        sel=>sig_sel,output_int=>sig_hex);
                        
DEC: seg_decoder port map(hex=>sig_hex,seg=>seven_seg);

end Behavioral;
