library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( x_fa : in STD_LOGIC;
           y_fa : in STD_LOGIC;
           c_out : out STD_LOGIC;
           s_fa : out STD_LOGIC;
           c_in : in STD_LOGIC);
           
end FullAdder;


architecture Behavioral of FullAdder is
component HalfAdder is
    Port ( x_ha : in STD_LOGIC;
           y_ha : in STD_LOGIC;
           s_ha : out STD_LOGIC;
           c_ha : out STD_LOGIC);
end component;

signal s1,c1,c2: STD_LOGIC;  
begin
HalfAdder1: HalfAdder port map (x_fa,y_fa,s1,c1);
HalfAdder2: HalfAdder port Map (s1,c_in,s_fa,c2);

c_out <= c2 or c1;

end Behavioral;
