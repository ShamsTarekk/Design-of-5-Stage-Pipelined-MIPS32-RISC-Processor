library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IF_ID_reg_tb is
end IF_ID_reg_tb;

architecture behavior of IF_ID_reg_tb is

    -- Signal declarations for the IF_ID_reg module
    signal clk         : std_logic := '0';
    signal stallD      : std_logic := '0';
    signal RD          : std_logic_vector(31 downto 0) := (others => '0');
    signal PCplus4IF   : std_logic_vector(31 downto 0) := (others => '0');
    signal PCsrcD      : std_logic := '0';
    
    -- Outputs
    signal PCplus4ID   : std_logic_vector(31 downto 0);
    signal Instr_ID    : std_logic_vector(31 downto 0);

    -- Instantiate the IF_ID_reg unit under test (UUT)
    component IF_ID_reg is
        port (
            clk         : in std_logic;
            stallD      : in std_logic;
            RD          : in std_logic_vector(31 downto 0);
            PCplus4IF   : in std_logic_vector(31 downto 0);
            PCsrcD      : in std_logic;
            PCplus4ID   : out std_logic_vector(31 downto 0);
            Instr_ID    : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- Instantiate the IF_ID_reg component
    uut: IF_ID_reg
        port map (
            clk         => clk,
            stallD      => stallD,
            RD          => RD,
            PCplus4IF   => PCplus4IF,
            PCsrcD      => PCsrcD,
            PCplus4ID   => PCplus4ID,
            Instr_ID    => Instr_ID
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
        -- Test 1: Initialize and load an instruction with PC + 4
        RD <= x"00000001"; -- Some instruction
        PCplus4IF <= x"00000004"; -- PC + 4
        stallD <= '0';
        PCsrcD <= '0';
        wait for 20 ns;

        -- Test 2: Apply stall signal and check that no new values are loaded
        stallD <= '1'; -- Stall signal asserted, should not update
        wait for 20 ns;

        -- Test 3: Remove stall signal and load new values
        stallD <= '0'; -- Stall signal removed
        RD <= x"00000002"; -- New instruction
        PCplus4IF <= x"00000008"; -- New PC + 4
        wait for 20 ns;

        -- Test 4: Apply branch signal and check if registers are cleared (branch taken)
        PCsrcD <= '1'; -- Branch taken, should clear the pipeline registers
        wait for 20 ns;

        -- Test 5: Apply stall signal with branch and check if registers remain cleared
        stallD <= '1'; -- Stall signal with branch
        wait for 20 ns;

        -- Test 6: Remove stall signal and verify instruction loading after branch
        stallD <= '0'; -- Stall signal removed
        PCsrcD <= '0'; -- No branch, instruction should load again
        RD <= x"00000003"; -- Another new instruction
        PCplus4IF <= x"0000000C"; -- New PC + 4
        wait for 20 ns;

        -- End of simulation
        wait;
    end process;

end behavior;
