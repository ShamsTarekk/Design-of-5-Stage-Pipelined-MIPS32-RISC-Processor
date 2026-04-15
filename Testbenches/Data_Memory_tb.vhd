library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory_tb is
end Memory_tb;

architecture behavior of Memory_tb is

    -- Signal declarations for the Memory module
    signal clk     : std_logic := '0';
    signal WE      : std_logic := '0';  -- Write enable
    signal A       : std_logic_vector(31 downto 0) := (others => '0');  -- Address
    signal WD      : std_logic_vector(31 downto 0) := (others => '0');  -- Write data
    signal RD      : std_logic_vector(31 downto 0);  -- Read data

    -- Instantiate the Memory unit under test (UUT)
    component Memory is
        Port (
            clk : in std_logic;
            WE  : in std_logic;
            A   : in std_logic_vector(31 downto 0);
            WD  : in std_logic_vector(31 downto 0);
            RD  : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- Instantiate the Memory component
    uut: Memory
        port map (
            clk => clk,
            WE  => WE,
            A   => A,
            WD  => WD,
            RD  => RD
        );

    -- Clock generation process
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process to drive the inputs and observe the outputs
    stim_proc: process
    begin
        -- Test 1: Write data to address 0x00000004
        WE <= '1';  -- Enable write
        A <= x"00000004";  -- Address to write data to
        WD <= x"DEADBEEF";  -- Write data
        wait for 20 ns;  -- Wait for the write to complete
        
        -- Test 2: Read data from address 0x00000004
        WE <= '0';  -- Disable write, enable read
        A <= x"00000004";  -- Read data from the same address
        wait for 20 ns;  -- Wait for the read to complete
        assert (RD = x"DEADBEEF") report "Test 2 Failed: Data read mismatch!" severity error;

        -- Test 3: Write data to address 0x00000008
        WE <= '1';  -- Enable write
        A <= x"00000008";  -- Address to write data to
        WD <= x"CAFEBABE";  -- Write data
        wait for 20 ns;  -- Wait for the write to complete
        
        -- Test 4: Read data from address 0x00000008
        WE <= '0';  -- Disable write, enable read
        A <= x"00000008";  -- Read data from the same address
        wait for 20 ns;  -- Wait for the read to complete
        assert (RD = x"CAFEBABE") report "Test 4 Failed: Data read mismatch!" severity error;

        -- Test 5: Ensure no data is written to an unaddressed region
        WE <= '1';  -- Enable write
        A <= x"0000000C";  -- Address to write data to
        WD <= x"BAADF00D";  -- Write data
        wait for 20 ns;
        -- Read from a different address to verify no accidental overwrite
        WE <= '0';  -- Disable write, enable read
        A <= x"00000004";  -- Read from a different address
        wait for 20 ns;
        assert (RD = x"DEADBEEF") report "Test 5 Failed: Data at 0x00000004 was overwritten!" severity error;

        -- End of simulation
        wait;
    end process;

end behavior;
