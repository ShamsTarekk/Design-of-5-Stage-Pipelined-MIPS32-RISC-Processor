library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity id_ex_reg_tb is
end id_ex_reg_tb;

architecture behavior of id_ex_reg_tb is

    -- Signal declarations for the id_ex_reg module
    signal CLK           : std_logic := '0';
    signal FlushE        : std_logic := '0';
    signal RegWriteD     : std_logic := '0';
    signal MemtoRegD     : std_logic := '0';
    signal MemWriteD     : std_logic := '0';
    signal ALUControlD   : std_logic_vector(2 downto 0) := (others => '0');
    signal ALUSrcD       : std_logic := '0';
    signal RegDstD       : std_logic := '0';
    signal RD1           : std_logic_vector(31 downto 0) := (others => '0');
    signal RD2           : std_logic_vector(31 downto 0) := (others => '0');
    signal RD3           : std_logic_vector(31 downto 0) := (others => '0');
    signal rsD           : std_logic_vector(4 downto 0) := (others => '0');
    signal rtD           : std_logic_vector(4 downto 0) := (others => '0');
    signal rdD           : std_logic_vector(4 downto 0) := (others => '0');
    signal SignImmD      : std_logic_vector(31 downto 0) := (others => '0');

    -- Outputs
    signal RegWriteE     : std_logic;
    signal MemtoRegE     : std_logic;
    signal MemWriteE     : std_logic;
    signal ALUControlE   : std_logic_vector(2 downto 0);
    signal ALUSrcE       : std_logic;
    signal RegDstE       : std_logic;
    signal RD1E          : std_logic_vector(31 downto 0);
    signal RD2E          : std_logic_vector(31 downto 0);
    signal RD3E          : std_logic_vector(31 downto 0);
    signal rsE           : std_logic_vector(4 downto 0);
    signal rtE           : std_logic_vector(4 downto 0);
    signal rdE           : std_logic_vector(4 downto 0);
    signal SignImmE      : std_logic_vector(31 downto 0);

    -- Instantiate the id_ex_reg unit under test (UUT)
    component id_ex_reg is
        Port (
            CLK           : IN  STD_LOGIC;
            FlushE        : IN  STD_LOGIC;
            RegWriteD     : IN  STD_LOGIC;
            MemtoRegD     : IN  STD_LOGIC;
            MemWriteD     : IN  STD_LOGIC;
            ALUControlD   : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
            ALUSrcD       : IN  STD_LOGIC;
            RegDstD       : IN  STD_LOGIC;
            RD1           : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
            RD2           : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
            RD3           : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
            rsD           : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
            rtD           : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
            rdD           : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
            SignImmD      : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
            RegWriteE     : OUT STD_LOGIC;
            MemtoRegE     : OUT STD_LOGIC;
            MemWriteE     : OUT STD_LOGIC;
            ALUControlE   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            ALUSrcE       : OUT STD_LOGIC;
            RegDstE       : OUT STD_LOGIC;
            RD1E          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            RD2E          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            RD3E          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            rsE           : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            rtE           : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            rdE           : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            SignImmE      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;

begin

    -- Instantiate the id_ex_reg component
    uut: id_ex_reg
        port map (
            CLK           => CLK,
            FlushE        => FlushE,
            RegWriteD     => RegWriteD,
            MemtoRegD     => MemtoRegD,
            MemWriteD     => MemWriteD,
            ALUControlD   => ALUControlD,
            ALUSrcD       => ALUSrcD,
            RegDstD       => RegDstD,
            RD1           => RD1,
            RD2           => RD2,
            RD3           => RD3,
            rsD           => rsD,
            rtD           => rtD,
            rdD           => rdD,
            SignImmD      => SignImmD,
            RegWriteE     => RegWriteE,
            MemtoRegE     => MemtoRegE,
            MemWriteE     => MemWriteE,
            ALUControlE   => ALUControlE,
            ALUSrcE       => ALUSrcE,
            RegDstE       => RegDstE,
            RD1E          => RD1E,
            RD2E          => RD2E,
            RD3E          => RD3E,
            rsE           => rsE,
            rtE           => rtE,
            rdE           => rdE,
            SignImmE      => SignImmE
        );

    -- Clock generation process
    clk_process: process
    begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process to drive the inputs and observe the outputs
    stim_proc: process
    begin
        -- Initializing inputs
        RegWriteD <= '1';
        MemtoRegD <= '1';
        MemWriteD <= '1';
        ALUControlD <= "010"; -- Example ALU control signal
        ALUSrcD <= '1';
        RegDstD <= '1';
        RD1 <= x"00000001";
        RD2 <= x"00000002";
        RD3 <= x"00000003";
        rsD <= "00001";
        rtD <= "00010";
        rdD <= "00011";
        SignImmD <= x"00000004";

        -- Test 1: Apply inputs and wait for 1 clock cycle
        wait for 20 ns;

        -- Test 2: Apply flush signal and check the outputs
        FlushE <= '1';
        wait for 20 ns;
        
        -- Test 3: Apply flush signal off and check outputs
        FlushE <= '0';
        wait for 20 ns;

        -- Test 4: Change input values and check the outputs again
        RegWriteD <= '0';
        MemtoRegD <= '0';
        MemWriteD <= '0';
        ALUControlD <= "111"; -- Change ALU control signal
        ALUSrcD <= '0';
        RegDstD <= '0';
        RD1 <= x"00000005";
        RD2 <= x"00000006";
        RD3 <= x"00000007";
        rsD <= "00100";
        rtD <= "00101";
        rdD <= "00110";
        SignImmD <= x"00000008";
        wait for 20 ns;

        -- End of simulation
        wait;
    end process;

end behavior;
