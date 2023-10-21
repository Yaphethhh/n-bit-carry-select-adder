library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HalfAdder is
    Port ( x_ha : in STD_LOGIC;
           y_ha : in STD_LOGIC;
           s_ha : out STD_LOGIC;
           c_ha : out STD_LOGIC);
end HalfAdder;

architecture Behavioral of HalfAdder is

begin
s_ha <= x_ha xor y_ha;
c_ha <= x_ha and y_ha;
end Behavioral;
