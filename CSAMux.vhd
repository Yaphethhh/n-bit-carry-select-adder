library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CSAMux is
    generic(n: integer := 8);
        port( 
            A,B : in STD_LOGIC_VECTOR (n downto 0);
            Sel: in STD_LOGIC;
            Z: out STD_LOGIC_VECTOR (n downto 0)
            );
end CSAMux;
 
architecture Behavioral of CSAMux is
    begin
    process(A,B,Sel)
        begin
            if Sel = '0' then
                Z <= A;
            else
                Z <= B;
            end if;
    end process;

end Behavioral;
