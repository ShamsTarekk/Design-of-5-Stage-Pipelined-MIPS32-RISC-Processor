library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mem_WB_reg_tb is
end Mem_WB_reg_tb;

architecture behavior of Mem_WB_reg_tb is

    -- Signal declarations
    signal clk                : std_logic := '0';
    signal RDM                : std_logic_vector(31 downto 0) := (others => '0');  -- Memory data input
    signal ALUOutM            : std_logic_vector(31 downto 0) := (others => '0');  -- ALU result from MEM stage
    signal WriteRegM          : std_logic_vector(4 downto 0) := "00000";  -- Write register address from MEM stage
    signal RegWriteM          : std_logic := '0';  -- RegWrite control signal
    signal MemtoRegM          : std_logic := '0';  -- MemtoReg control signal
    
    signal RDW                : std_logic_vector(31 downto 0);  -- Memory data output
    signal ALUOutW            : std_logic_vector(31 downto 0);  -- ALU result output
    signal WriteRegW          : std_logic_vector(4 downto 0);    -- Write register address output
    signal RegWriteW          : std_logic;                       -- RegWrite control output
    signal MemtoRegW          : std_logic;                       -- MemtoReg control output

    -- Instantiate the Mem_WB_reg unit under test (UUT)
    component Mem_WB_reg is
        port (
            clk                : in  std_logic;
            RDM                : in  std_logic_vector(31 downto 0);
            ALUOutM            : in  std_logic_vector(31 downto 0);
            WriteRegM          : in  std_logic_vector(4 downto 0);
            RegWriteM          : in  std_logic;
            MemtoRegM          : in  std_logic;
            
            RDW                : out std_logic_vector(31 downto 0);
            ALUOutW            : out std_logic_vector(31 downto 0);
            WriteRegW          : out std_logic_vector(4 downto 0);
            RegWriteW          : out std_logic;
            MemtoRegW          : out std_logic
        );
    end component;

begin

    -- Instantiate Mem_WB_reg
    uut: Mem_WB_reg
        port map (
            clk                => clk,
            RDM                => RDM,
            ALUOutM            => ALUOutM,
            WriteRegM          => WriteRegM,
            RegWriteM          => RegWriteM,
            MemtoRegM          => MemtoRegM,
            
            RDW                => RDW,
            ALUOutW            => ALUOutW,
            WriteRegW          => WriteRegW,
            RegWriteW          => RegWriteW,
            MemtoRegW          => MemtoRegW
        );

    -- Clock generation process
    clk_process : process
    begin
        clk <= not clk after 10 ns;  -- Toggle clock every 10 ns
        wait for 10 ns;
    end process;

    -- Stimulus process to apply inputs and observe outputs
    stim_proc: process
    begin
        -- Initial state
        wait for 20 ns; -- Wait for a few clock cycles

        -- Test 1: Apply values to signals
        RDM <= x"12345678";
        ALUOutM <= x"87654321";
        WriteRegM <= "00001";
        RegWriteM <= '1';
        MemtoRegM <= '0';
        wait for 20 ns;

        -- Test 2: Apply different values
        RDM <= x"abcdef12";
        ALUOutM <= x"1234abcd";
        WriteRegM <= "00010";
        RegWriteM <= '0';
        MemtoRegM <= '1';
        wait for 20 ns;

        -- Test 3: Change RegWriteM to '0' (write disabled)
        RegWriteM <= '0'; -- Disable RegWrite
        wait for 20 ns;

        -- Test 4: Change MemtoRegM to '1' (indicating data should come from memory)
        MemtoRegM <= '1'; -- Memory to register
        wait for 20 ns;

        -- Test 5: Re-enable RegWriteM
        RegWriteM <= '1'; -- Enable RegWrite again
        wait for 20 ns;

        -- End of simulation
        wait;
    end process;

end behavior;
