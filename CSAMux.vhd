----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/14/2023 02:00:21 PM
-- Design Name: 
-- Module Name: CSAMux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
