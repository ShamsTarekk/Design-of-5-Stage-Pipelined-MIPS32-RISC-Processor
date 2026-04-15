library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Write_back_tb is
end Write_back_tb;

architecture behavior of Write_back_tb is

    -- Signal declarations
    signal MemtoRegW  : std_logic := '0';
    signal ReadDataW  : std_logic_vector(31 downto 0) := (others => '0');
    signal AlUOutW    : std_logic_vector(31 downto 0) := (others => '0');
    signal ResultW    : std_logic_vector(31 downto 0);

    -- Instantiate the Write_back unit under test (UUT)
    component Write_back is
        port (
            MemtoRegW : in std_logic;
            ReadDataW : in std_logic_vector(31 downto 0);
            AlUOutW   : in std_logic_vector(31 downto 0);
            ResultW   : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- Instantiate Write_back
    uut: Write_back
        port map (
            MemtoRegW => MemtoRegW,
            ReadDataW => ReadDataW,
            AlUOutW   => AlUOutW,
            ResultW   => ResultW
        );

    -- Clock and stimulus process to apply inputs and observe outputs
    stim_proc: process
    begin
        -- Initial state
        wait for 20 ns;

        -- Test 1: MemtoRegW = '1', so ResultW should come from ReadDataW
        MemtoRegW <= '1';
        ReadDataW <= x"12345678";  -- Some arbitrary data
        AlUOutW <= x"87654321";   -- Some arbitrary data
        wait for 20 ns;
        assert (ResultW = x"12345678") report "Test 1 Failed" severity error;

        -- Test 2: MemtoRegW = '0', so ResultW should come from AlUOutW
        MemtoRegW <= '0';
        ReadDataW <= x"abcdef12";  -- New value for ReadDataW
        AlUOutW <= x"56789abc";    -- New value for AlUOutW
        wait for 20 ns;
        assert (ResultW = x"56789abc") report "Test 2 Failed" severity error;

        -- Test 3: Change values again and verify
        MemtoRegW <= '1';
        ReadDataW <= x"11223344";  -- New value for ReadDataW
        AlUOutW <= x"55667788";    -- New value for AlUOutW
        wait for 20 ns;
        assert (ResultW = x"11223344") report "Test 3 Failed" severity error;

        -- End of simulation
        wait;
    end process;

end behavior;
