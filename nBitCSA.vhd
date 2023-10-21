library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nBitCSA is
    generic (n: integer := 64);
    Port (
        c_in : in STD_LOGIC;
        c_out: out STD_LOGIC;
        address: in STD_LOGIC_VECTOR(3 downto 0);
        en: in STD_LOGIC;
        clk: in STD_LOGIC;
        s: out STD_LOGIC_VECTOR (n-1 downto 0);
        data: out STD_LOGIC_VECTOR (n-1 downto 0)
    );
end nBitCSA;

architecture Behavioral of nBitCSA is
    component FullAdder is
        Port (
            x_fa  : in STD_LOGIC;
            y_fa  : in STD_LOGIC;
            c_out : out STD_LOGIC;
            s_fa  : out STD_LOGIC;
            c_in  : in STD_LOGIC
        );
    end component;
    component CSAMux is
        port (
            A   : in STD_LOGIC_VECTOR ((n/2) downto 0);
            B   : in STD_LOGIC_VECTOR ((n/2) downto 0);
            Sel : in STD_LOGIC;
            Z   : out STD_LOGIC_VECTOR ((n/2) downto 0)
        );
    end component;

    -- Define a ROM component
    component romFile is
        Port (
            address : in STD_LOGIC_VECTOR(3 downto 0);
            data    : out STD_LOGIC_VECTOR(n-1 downto 0);
            en : in std_logic;
            clk : in std_logic
        );
    end component romFile;

    component romFile2 is
            Port (
            address : in STD_LOGIC_VECTOR(3 downto 0);
            data    : out STD_LOGIC_VECTOR(63 downto 0);
            en : in std_logic;
            clk : in std_logic
        );
    end component romFile2;

    -- Add the WriteRegister component
    component writeReg is
        Port (
            clk     : in std_logic;
            a_addr  : in std_logic_vector(3 downto 0);
            a_data  : in std_logic_vector(n-1 downto 0);
            load    : in std_logic;
            data_out: out std_logic_vector(n-1 downto 0)
        );
    end component;

    signal c  : STD_LOGIC_VECTOR ((n/2) downto 0);
    signal c1 : STD_LOGIC_VECTOR ((n/2) downto 0);
    signal c0 : STD_LOGIC_VECTOR ((n/2) downto 0);
    signal s1, s0 : STD_LOGIC_VECTOR (n/2 downto 0);
    signal Carry_out: STD_LOGIC_VECTOR (n/2 downto 0);
    signal rom_data : STD_LOGIC_VECTOR(n-1 downto 0); -- Data from the ROM
    signal rom_data1 : STD_LOGIC_VECTOR(n-1 downto 0); -- Data from the ROM
    signal data_out  : STD_LOGIC_VECTOR(n-1 downto 0);
    -- Add a signal to store the data to be written to the WriteRegister
    signal data_to_write : STD_LOGIC_VECTOR(n-1 downto 0);
    signal sum: STD_LOGIC_VECTOR(n-1 downto 0);
begin
    -- ROM instance
    rom_inst : romFile
        port map (address => address, data => rom_data, en => en, clk => clk);
    rom_inst2 : romFile2
        port map (address => address, data => rom_data1, en => en, clk => clk);

    -- Initialization
    c(0) <= c_in;
    c_out <= c(n/2);
    c0(0) <= '0';
    c1(0) <= '1';

    -- n-bit ripple carry adder
    fa: for i in 0 to (n/2)-1 generate 
        fa_I: FullAdder port map(rom_data(i), rom_data1(i), c(i+1), sum(i), c(i));
    end generate;
    s((n/2-1) downto 0) <= sum((n/2-1) downto 0);

    -- Carry with 0
    fa_0: for i in 0 to (n/2)-1 generate 
        fa_0_I: FullAdder port map(rom_data(i+(n/2)), rom_data1(i+(n/2)), c0(i+1), s0(i), c0(i));
    end generate;

    -- Carry with 1
    fa_1: for i in 0 to (n/2)-1 generate 
        fa_1_I: FullAdder port map(rom_data(i+(n/2)), rom_data1(i+(n/2)), c1(i+1), s1(i), c1(i));
    end generate;

    s0(n/2) <= c0(n/2);
    s1(n/2) <= c1(n/2);

    Mux: CSAMux port map(s0, s1, c(n/2), Carry_out);

    sum(n-1 downto n/2) <= Carry_out((n/2-1) downto 0);
    s(n-1 downto n/2) <= Carry_out((n/2-1) downto 0);
    c_out <= Carry_out(n/2);

    -- Instantiate the WriteRegister component
    write_register_inst : writeReg
        port map (
            clk     => clk,
            a_addr  => address,
            a_data  => sum,
            load    => en,
            data_out => data
        );
end Behavioral;
