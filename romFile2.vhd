library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity romFile2 is
  generic(n: integer := 16);
  port (
    address : in std_logic_vector(3 downto 0);
    data : out std_logic_vector(n-1 downto 0); -- Changed to 64 bits
    en : in std_logic;
    clk : in std_logic
  );
end entity romFile2;

architecture behavioral of romFile2 is
  type mem is array (0 to 15) of std_logic_vector(n-1 downto 0); -- Changed to 64 bits
  constant my_rom : mem := (
    x"0041",  -- 16-bit hexadecimal value
    x"0001",
    x"0010",
    x"0011",
    x"0010",
    x"0011",
    x"0110",
    x"0111",
    x"1000",
    x"1001",
    x"1010",
    x"1011",
    x"1100",
    x"1101",
    x"1110",
    x"1111"
  );

begin
  process (clk)
  begin
    if rising_edge(clk) then
      if en = '1' then
        case address is
          when "0000" =>
            data <= my_rom(0);
          when "0001" =>
            data <= my_rom(1);
          when "0010" =>
            data <= my_rom(2);
          when "0011" =>
            data <= my_rom(3);
          when "0100" =>
            data <= my_rom(4);
          when "0101" =>
            data <= my_rom(5);
          when "0110" =>
            data <= my_rom(6);
          when "0111" =>
            data <= my_rom(7);
          when "1000" =>
            data <= my_rom(8);
          when "1001" =>
            data <= my_rom(9);
          when "1010" =>
            data <= my_rom(10);
          when "1011" =>
            data <= my_rom(11);
          when "1100" =>
            data <= my_rom(12);
          when "1101" =>
            data <= my_rom(13);
          when "1110" =>
            data <= my_rom(14);
          when "1111" =>
            data <= my_rom(15);
          when others =>
            data <= (others => '0');
        end case;
      end if;
    end if;
  end process;
end architecture behavioral;

