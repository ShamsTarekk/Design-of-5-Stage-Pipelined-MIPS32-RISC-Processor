library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex_mem_reg_tb is
end ex_mem_reg_tb;

architecture behavior of ex_mem_reg_tb is

    -- Signal declarations for the ex_mem_reg module
    signal clk          : std_logic := '0';
    signal RegWriteE    : std_logic := '0';
    signal MemtoRegE    : std_logic := '0';
    signal MemWriteE    : std_logic := '0';
    signal ALUoutE      : std_logic_vector(31 downto 0) := (others => '0');
    signal WriteDataE   : std_logic_vector(31 downto 0) := (others => '0');
    signal WriteRegE    : std_logic_vector(4 downto 0) := (others => '0');
    
    signal RegWriteM    : std_logic;
    signal MemtoRegM    : std_logic;
    signal MemWriteM    : std_logic;
    signal ALUoutM      : std_logic_vector(31 downto 0);
    signal WriteDataM   : std_logic_vector(31 downto 0);
    signal WriteRegM    : std_logic_vector(4 downto 0);

    -- Instantiate the ex_mem_reg unit under test (UUT)
    component ex_mem_reg is
        Port (
            clk          : in  std_logic;
            RegWriteE    : in  std_logic;
            MemtoRegE    : in  std_logic;
            MemWriteE    : in  std_logic;
            ALUoutE      : in  std_logic_vector(31 downto 0);
            WriteDataE   : in  std_logic_vector(31 downto 0);
            WriteRegE    : in  std_logic_vector(4 downto 0);
            RegWriteM    : out std_logic;
            MemtoRegM    : out std_logic;
            MemWriteM    : out std_logic;
            ALUoutM      : out std_logic_vector(31 downto 0);
            WriteDataM   : out std_logic_vector(31 downto 0);
            WriteRegM    : out std_logic_vector(4 downto 0)
        );
    end component;

begin

    -- Instantiate the ex_mem_reg component
    uut: ex_mem_reg
        port map (
            clk          => clk,
            RegWriteE    => RegWriteE,
            MemtoRegE    => MemtoRegE,
            MemWriteE    => MemWriteE,
            ALUoutE      => ALUoutE,
            WriteDataE   => WriteDataE,
            WriteRegE    => WriteRegE,
            RegWriteM    => RegWriteM,
            MemtoRegM    => MemtoRegM,
            MemWriteM    => MemWriteM,
            ALUoutM      => ALUoutM,
            WriteDataM   => WriteDataM,
            WriteRegM    => WriteRegM
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
        -- Initializing inputs
        RegWriteE <= '0';
        MemtoRegE <= '0';
        MemWriteE <= '0';
        ALUoutE <= x"00000000";
        WriteDataE <= x"00000000";
        WriteRegE <= x"00000";

        -- Test 1: Apply inputs, check outputs
        wait for 20 ns;
        RegWriteE <= '1';
        MemtoRegE <= '1';
        MemWriteE <= '1';
        ALUoutE <= x"12345678";
        WriteDataE <= x"87654321";
        WriteRegE <= x"00001";
        wait for 20 ns;
        
        -- Test 2: Check outputs after one clock cycle
        assert (RegWriteM = '1') report "Test 2 Failed: RegWriteM mismatch!" severity error;
        assert (MemtoRegM = '1') report "Test 2 Failed: MemtoRegM mismatch!" severity error;
        assert (MemWriteM = '1') report "Test 2 Failed: MemWriteM mismatch!" severity error;
        assert (ALUoutM = x"12345678") report "Test 2 Failed: ALUoutM mismatch!" severity error;
        assert (WriteDataM = x"87654321") report "Test 2 Failed: WriteDataM mismatch!" severity error;
        assert (WriteRegM = x"00001") report "Test 2 Failed: WriteRegM mismatch!" severity error;

        -- Test 3: Apply different values, check outputs
        wait for 20 ns;
        RegWriteE <= '0';
        MemtoRegE <= '0';
        MemWriteE <= '0';
        ALUoutE <= x"ABCDEF01";
        WriteDataE <= x"12345678";
        WriteRegE <= x"00010";
        wait for 20 ns;
        
        -- Test 4: Check outputs after one clock cycle with different values
        assert (RegWriteM = '0') report "Test 4 Failed: RegWriteM mismatch!" severity error;
        assert (MemtoRegM = '0') report "Test 4 Failed: MemtoRegM mismatch!" severity error;
        assert (MemWriteM = '0') report "Test 4 Failed: MemWriteM mismatch!" severity error;
        assert (ALUoutM = x"ABCDEF01") report "Test 4 Failed: ALUoutM mismatch!" severity error;
        assert (WriteDataM = x"12345678") report "Test 4 Failed: WriteDataM mismatch!" severity error;
        assert (WriteRegM = x"00010") report "Test 4 Failed: WriteRegM mismatch!" severity error;

        -- End of simulation
        wait;
    end process;

end behavior;
