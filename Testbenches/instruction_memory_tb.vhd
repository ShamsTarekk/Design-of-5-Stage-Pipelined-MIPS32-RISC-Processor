library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
USE IEEE.NUMERIC_STD.ALL;     

entity instruction_memory_tb is
end instruction_memory_tb;

architecture behavior of instruction_memory_tb is

    -- Signal declarations for the instruction_memory module
    signal A  : std_logic_vector(31 downto 0) := (others => '0');
    signal RD : std_logic_vector(31 downto 0);

    -- Component declaration of the instruction_memory
    component instruction_memory is
        Port (
            A  : in STD_LOGIC_VECTOR(31 downto 0); -- Address input
            RD : out STD_LOGIC_VECTOR(31 downto 0) -- Instruction output
        );
    end component;

begin

    -- Instantiate the instruction_memory unit under test (UUT)
    uut: instruction_memory
        port map (
            A  => A,
            RD => RD
        );

    -- Stimulus process to drive the inputs and observe the outputs
    stim_proc: process
    begin
        -- Test 1: Access instruction at address 0x0 (ADD instruction)
        A <= x"00000000"; -- Address 0
        wait for 20 ns;

        -- Test 2: Access instruction at address 0x4 (SUB instruction)
        A <= x"00000004"; -- Address 4
        wait for 20 ns;

        -- Test 3: Access instruction at address 0x8 (ADDI instruction)
        A <= x"00000008"; -- Address 8
        wait for 20 ns;

        -- Test 4: Access instruction at address 0xC (SUBI instruction)
        A <= x"0000000C"; -- Address 12
        wait for 20 ns;

        -- Test 5: Access instruction at address 0x10 (AND instruction)
        A <= x"00000010"; -- Address 16
        wait for 20 ns;

        -- Test 6: Access instruction at address 0x14 (OR instruction)
        A <= x"00000014"; -- Address 20
        wait for 20 ns;

        -- Test 7: Access instruction at address 0x18 (LW instruction)
        A <= x"00000018"; -- Address 24
        wait for 20 ns;

        -- Test 8: Access instruction at address 0x1C (SW instruction)
        A <= x"0000001C"; -- Address 28
        wait for 20 ns;

        -- Test 9: Access instruction at address 0x20 (ANN instruction)
        A <= x"00000020"; -- Address 32
        wait for 20 ns;

        -- Test 10: Access instruction at address 0x24 (WGHT instruction)
        A <= x"00000024"; -- Address 36
        wait for 20 ns;

        -- Test 11: Access instruction at address 0x28 (BEQZ instruction)
        A <= x"00000028"; -- Address 40
        wait for 20 ns;

        -- Test 12: Access unused memory (address 0x30)
        A <= x"00000030"; -- Address 48 (should be zero)
        wait for 20 ns;

        -- End of simulation
        wait;
    end process;

end behavior;
