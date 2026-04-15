library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_control_unit is
    -- No ports for the testbench
end tb_control_unit;

architecture Behavioral of tb_control_unit is

    -- Component declaration for the Unit Under Test (UUT)
    component control_unit
        port (
            opcode      : in  std_logic_vector(5 downto 0);   -- opcode input
            funct       : in  std_logic_vector(5 downto 0);   -- funct input
            RegWriteD   : out std_logic;                       -- Register write enable
            MemWriteD   : out std_logic;                       -- Memory write enable
            MemtoRegD   : out std_logic;                       -- Memory to register
            ALUControlD : out std_logic_vector(2 downto 0);    -- ALU control
            ALUSrcD     : out std_logic;                       -- ALU source (1 for immediate)
            RegDstD     : out std_logic;                       -- Register destination (1 for rd)
            BranchD     : out std_logic                        -- Branch control (1 for branch)
        );
    end component;

    -- Signals to connect to UUT
    signal opcode      : std_logic_vector(5 downto 0);
    signal funct       : std_logic_vector(5 downto 0);
    signal RegWriteD   : std_logic;
    signal MemWriteD   : std_logic;
    signal MemtoRegD   : std_logic;
    signal ALUControlD : std_logic_vector(2 downto 0);
    signal ALUSrcD     : std_logic;
    signal RegDstD     : std_logic;
    signal BranchD     : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the UUT
    uut: control_unit
        port map (
            opcode      => opcode,
            funct       => funct,
            RegWriteD   => RegWriteD,
            MemWriteD   => MemWriteD,
            MemtoRegD   => MemtoRegD,
            ALUControlD => ALUControlD,
            ALUSrcD     => ALUSrcD,
            RegDstD     => RegDstD,
            BranchD     => BranchD
        );

    -- Stimulus process
    stim_proc : process
    begin
        -- Test Case 1: R-Type ADD instruction (opcode = "000000", funct = "111111")
        opcode <= "000000";  -- R-Type
        funct <= "111111";   -- ADD
        wait for clk_period;
        assert (RegWriteD = '1' and MemWriteD = '0' and MemtoRegD = '0' and ALUControlD = "010" and ALUSrcD = '0' and RegDstD = '1' and BranchD = '0')
            report "Test Case 1 Failed!" severity error;

        -- Test Case 2: R-Type SUB instruction (opcode = "000000", funct = "111110")
        funct <= "111110";   -- SUB
        wait for clk_period;
        assert (ALUControlD = "011") report "Test Case 2 Failed!" severity error;

        -- Test Case 3: Load Word (LW) instruction (opcode = "100000")
        opcode <= "100000";  -- LW
        funct <= (others => '0'); -- No funct for LW
        wait for clk_period;
        assert (RegWriteD = '1' and MemWriteD = '0' and MemtoRegD = '1' and ALUControlD = "010" and ALUSrcD = '1' and RegDstD = '0' and BranchD = '0')
            report "Test Case 3 Failed!" severity error;

        -- Test Case 4: Store Word (SW) instruction (opcode = "100001")
        opcode <= "100001";  -- SW
        wait for clk_period;
        assert (RegWriteD = '0' and MemWriteD = '1' and MemtoRegD = '0' and ALUControlD = "010" and ALUSrcD = '1' and RegDstD = '0' and BranchD = '0')
            report "Test Case 4 Failed!" severity error;

        -- Test Case 5: Branch Equal Zero (BEQZ) instruction (opcode = "100010")
        opcode <= "100010";  -- BEQZ
        wait for clk_period;
        assert (RegWriteD = '0' and MemWriteD = '0' and MemtoRegD = '0' and ALUControlD = "011" and ALUSrcD = '0' and RegDstD = '0' and BranchD = '1')
            report "Test Case 5 Failed!" severity error;

        -- Test Case 6: ADDI instruction (opcode = "100011")
        opcode <= "100011";  -- ADDI
        wait for clk_period;
        assert (RegWriteD = '1' and MemWriteD = '0' and MemtoRegD = '0' and ALUControlD = "010" and ALUSrcD = '1' and RegDstD = '0' and BranchD = '0')
            report "Test Case 6 Failed!" severity error;

        -- Test Case 7: SUBI instruction (opcode = "100100")
        opcode <= "100100";  -- SUBI
        wait for clk_period;
        assert (RegWriteD = '1' and MemWriteD = '0' and MemtoRegD = '0' and ALUControlD = "011" and ALUSrcD = '1' and RegDstD = '0' and BranchD = '0')
            report "Test Case 7 Failed!" severity error;

        -- Test Case 8: WGHT instruction (opcode = "100110")
        opcode <= "100110";  -- WGHT
        wait for clk_period;
        assert (RegWriteD = '0' and MemWriteD = '0' and MemtoRegD = '0' and ALUControlD = "111" and ALUSrcD = '0' and RegDstD = '0' and BranchD = '0')
            report "Test Case 8 Failed!" severity error;

        -- End simulation
        wait;
    end process;

end Behavioral;
