library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WGHT_tb is
    -- No ports for the testbench entity
end WGHT_tb;

architecture Behavioral of WGHT_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component WGHT
        port (
            input1 : in std_logic_vector(31 downto 0);
            input2 : in std_logic_vector(31 downto 0);
            input3 : in std_logic_vector(31 downto 0);
            enable : in std_logic_vector(2 downto 0);
            clk : in std_logic
        );
    end component;

    -- Signals for UUT inputs
    signal input1 : std_logic_vector(31 downto 0) := (others => '0');
    signal input2 : std_logic_vector(31 downto 0) := (others => '0');
    signal input3 : std_logic_vector(31 downto 0) := (others => '0');
    signal enable : std_logic_vector(2 downto 0) := "000";
    signal clk : std_logic := '0';

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: WGHT
        port map (
            input1 => input1,
            input2 => input2,
            input3 => input3,
            enable => enable,
            clk => clk
        );

    -- Clock generation process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Initial Values
        input1 <= x"AAAAAAAA";
        input2 <= x"BBBBBBBB";
        input3 <= x"CCCCCCCC";

        -- Test Case 1: Enable not active
        enable <= "000";
        wait for 20 ns;

        -- Test Case 2: Enable active
        enable <= "111";
        wait for 20 ns;

        -- Test Case 3: Change inputs and enable active
        input1 <= x"11111111";
        input2 <= x"22222222";
        input3 <= x"33333333";
        wait for 20 ns;

        -- Test Case 4: Enable not active again
        enable <= "000";
        wait for 20 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
