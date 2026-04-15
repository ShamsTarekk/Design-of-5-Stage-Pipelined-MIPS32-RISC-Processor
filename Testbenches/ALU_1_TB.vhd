library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ALU
        Port (
            clk: in std_logic;
            SrcA: in std_logic_vector(31 downto 0);      
            SrcB: in std_logic_vector(31 downto 0);      
            SrcC: in std_logic_vector(31 downto 0);
            ALUControl: in std_logic_vector(2 downto 0); 
            ALUResult: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for the UUT
    signal clk: std_logic := '0';
    signal SrcA: std_logic_vector(31 downto 0) := (others => '0');
    signal SrcB: std_logic_vector(31 downto 0) := (others => '0');
    signal SrcC: std_logic_vector(31 downto 0) := (others => '0');
    signal ALUControl: std_logic_vector(2 downto 0) := "000";
    signal ALUResult: std_logic_vector(31 downto 0);
begin
    -- Clock Generation
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;


    -- Instantiate the Unit Under Test (UUT)
    uut: ALU port map (
        clk => clk,
        SrcA => SrcA,
        SrcB => SrcB,
        SrcC => SrcC,
        ALUControl => ALUControl,
        ALUResult => ALUResult
    );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: ADD operation
        SrcA <= x"00000010"; -- Operand A = 2
        SrcB <= x"00000003"; -- Operand B = 3
        ALUControl <= "010"; -- ADD
        wait for 20 ns;

        -- Test Case 2: SUB operation
        SrcA <= x"00000005"; -- Operand A = 5
        SrcB <= x"00000002"; -- Operand B = 2
        ALUControl <= "011"; -- SUB
        wait for 20 ns;

        -- Test Case 3: AND operation
        SrcA <= x"0000000F"; -- Operand A = 15
        SrcB <= x"0000000A"; -- Operand B = 10
        ALUControl <= "100"; -- AND
        wait for 20 ns;

        -- Test Case 4: OR operation
        SrcA <= x"0000000F"; -- Operand A = 15
        SrcB <= x"0000000A"; -- Operand B = 10
        ALUControl <= "101"; -- OR
        wait for 20 ns;

        -- Test Case 5: ANN operation (custom logic)
        SrcA <= x"00000002"; -- Operand A = 2
        SrcB <= x"00000003"; -- Operand B = 3
        SrcC <= x"00000004"; -- Operand C = 4
        ALUControl <= "110"; -- ANN
        wait for 20 ns;
        ALUControl <= "111";
        wait for 20 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
