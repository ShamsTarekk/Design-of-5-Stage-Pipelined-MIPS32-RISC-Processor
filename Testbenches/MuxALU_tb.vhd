library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxALU_tb is
    -- No ports in the testbench entity
end MuxALU_tb;

architecture Behavioral of MuxALU_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component MuxALU
        Port (
            ALUControl : in std_logic_vector(2 downto 0);  
            add_out    : in std_logic_vector(31 downto 0); 
            sub_out    : in std_logic_vector(31 downto 0); 
            and_out    : in std_logic_vector(31 downto 0); 
            or_out     : in std_logic_vector(31 downto 0); 
            ann_out    : in std_logic_vector(31 downto 0);
            Result     : out std_logic_vector(31 downto 0) 
        );
    end component;

    -- Inputs
    signal ALUControl : std_logic_vector(2 downto 0) := "000";
    signal add_out    : std_logic_vector(31 downto 0) := (others => '0');
    signal sub_out    : std_logic_vector(31 downto 0) := (others => '0');
    signal and_out    : std_logic_vector(31 downto 0) := (others => '0');
    signal or_out     : std_logic_vector(31 downto 0) := (others => '0');
    signal ann_out    : std_logic_vector(31 downto 0) := (others => '0');

    -- Outputs
    signal Result : std_logic_vector(31 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: MuxALU
        Port map (
            ALUControl => ALUControl,
            add_out    => add_out,
            sub_out    => sub_out,
            and_out    => and_out,
            or_out     => or_out,
            ann_out    => ann_out,
            Result     => Result
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: ALUControl = "010" (add_out)
        add_out <= x"AAAAAAAA"; -- Assign a test value
        ALUControl <= "010";
        wait for 10 ns;
        assert (Result = add_out) report "Test Case 1 Failed" severity error;

        -- Test Case 2: ALUControl = "011" (sub_out)
        sub_out <= x"BBBBBBBB"; -- Assign a test value
        ALUControl <= "011";
        wait for 10 ns;
        assert (Result = sub_out) report "Test Case 2 Failed" severity error;

        -- Test Case 3: ALUControl = "100" (and_out)
        and_out <= x"CCCCCCCC"; -- Assign a test value
        ALUControl <= "100";
        wait for 10 ns;
        assert (Result = and_out) report "Test Case 3 Failed" severity error;

        -- Test Case 4: ALUControl = "101" (or_out)
        or_out <= x"DDDDDDDD"; -- Assign a test value
        ALUControl <= "101";
        wait for 10 ns;
        assert (Result = or_out) report "Test Case 4 Failed" severity error;

        -- Test Case 5: ALUControl = "110" (ann_out)
        ann_out <= x"EEEEEEEE"; -- Assign a test value
        ALUControl <= "110";
        wait for 10 ns;
        assert (Result = ann_out) report "Test Case 5 Failed" severity error;

        -- Test Case 6: Default case (others => '0')
        ALUControl <= "111";
        wait for 10 ns;
        
        -- End of simulation
        wait;
    end process;
end Behavioral;
