library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Fetch_tb is
end Fetch_tb;

architecture behavior of Fetch_tb is

    -- Signal declarations
    signal clk             : std_logic := '0';
    signal STALLIF         : std_logic := '0'; -- No stall initially
    signal PCSrcD          : std_logic := '0'; -- No branch initially
    signal branch_target   : std_logic_vector(31 downto 0) := x"00000000"; -- Default branch target
    signal next_PC         : std_logic_vector(31 downto 0);
    signal RD              : std_logic_vector(31 downto 0);

    -- Instantiate the Fetch unit under test (UUT)
    component Fetch is
        Port (
            clk             : in std_logic;
            STALLIF         : IN STD_LOGIC; 
            PCSrcD          : in std_logic;
            branch_target   : in std_logic_vector(31 downto 0);    
            next_PC         : out std_logic_vector(31 downto 0);
            RD              : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- Instantiate Fetch module
    uut: Fetch
        port map (
            clk             => clk,
            STALLIF         => STALLIF,
            PCSrcD          => PCSrcD,
            branch_target   => branch_target,
            next_PC         => next_PC,
            RD              => RD
        );

    -- Clock generation process
    clk_process : process
    begin
        clk <= not clk after 10 ns;  -- Toggle clock every 10 ns
        wait for 10 ns;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial state
        wait for 20 ns; -- Wait for some time to allow the initial state

        -- Test 1: No branch, no stall, normal PC increment
        STALLIF <= '0';
        PCSrcD <= '0';
        branch_target <= x"00000000"; -- Default branch target
        wait for 20 ns;

        -- Test 2: Stall the fetch operation
        STALLIF <= '1'; -- STALLIF signal stalls the PC increment
        wait for 20 ns;

        -- Test 3: Branch taken, change PC to branch_target
        STALLIF <= '0'; -- No stall
        PCSrcD <= '1';  -- Branch is taken
        branch_target <= x"00000010"; -- New branch target address
        wait for 20 ns;

        -- Test 4: No branch, normal increment
        STALLIF <= '0'; -- No stall
        PCSrcD <= '0';  -- No branch
        branch_target <= x"00000000"; -- No change in target
        wait for 20 ns;

        -- Test 5: Branch taken again with a different target
        PCSrcD <= '1';  -- Branch taken
        branch_target <= x"00000020"; -- New branch target
        wait for 20 ns;

        -- End of test
        wait;
    end process;

end behavior;
