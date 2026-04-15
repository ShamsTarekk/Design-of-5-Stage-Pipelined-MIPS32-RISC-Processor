library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- For arithmetic operations if required.

entity tb_Execute is
    -- No ports for the testbench
end tb_Execute;

architecture Behavioral of tb_Execute is

    -- Component declaration for the Unit Under Test (UUT)
    component Execute
        port (
            clk                 : in std_logic;
            RD1                 : in std_logic_vector(31 downto 0);
            RD2                 : in std_logic_vector(31 downto 0);
            RD3                 : in std_logic_vector(31 downto 0);
            sign_extend         : in std_logic_vector(31 downto 0);
            alu_control         : in std_logic_vector(3 downto 0);
            alu_src             : in std_logic;
            rt                  : in std_logic_vector(4 downto 0);
            rd                  : in std_logic_vector(4 downto 0);
            reg_dst             : in std_logic;
            ForwardAE           : in std_logic_vector(1 downto 0);
            ForwardBE           : in std_logic_vector(1 downto 0);
            ForwardCE           : in std_logic_vector(1 downto 0);
            ALUout              : in std_logic_vector(31 downto 0);
            ResultW             : in std_logic_vector(31 downto 0);
            alu_result          : out std_logic_vector(31 downto 0);
            write_reg_address   : out std_logic_vector(4 downto 0);
            write_data          : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for the UUT
    signal clk                 : std_logic := '0';
    signal RD1, RD2, RD3       : std_logic_vector(31 downto 0) := (others => '0');
    signal sign_extend         : std_logic_vector(31 downto 0) := (others => '0');
    signal alu_control         : std_logic_vector(3 downto 0) := (others => '0');
    signal alu_src             : std_logic := '0';
    signal rt, rd              : std_logic_vector(4 downto 0) := (others => '0');
    signal reg_dst             : std_logic := '0';
    signal ForwardAE           : std_logic_vector(1 downto 0) := "00";
    signal ForwardBE           : std_logic_vector(1 downto 0) := "00";
    signal ForwardCE           : std_logic_vector(1 downto 0) := "00";
    signal ALUout, ResultW     : std_logic_vector(31 downto 0) := (others => '0');
    signal alu_result          : std_logic_vector(31 downto 0);
    signal write_reg_address   : std_logic_vector(4 downto 0);
    signal write_data          : std_logic_vector(31 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the UUT
    uut: Execute
        port map (
            clk => clk,
            RD1 => RD1,
            RD2 => RD2,
            RD3 => RD3,
            sign_extend => sign_extend,
            alu_control => alu_control,
            alu_src => alu_src,
            rt => rt,
            rd => rd,
            reg_dst => reg_dst,
            ForwardAE => ForwardAE,
            ForwardBE => ForwardBE,
            ForwardCE => ForwardCE,
            ALUout => ALUout,
            ResultW => ResultW,
            alu_result => alu_result,
            write_reg_address => write_reg_address,
            write_data => write_data
        );

    -- Clock generation
    clk_process : process
    begin
        while True loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Test Case 1: Basic forwarding disabled
        RD1 <= x"00000010";  -- Operand A
        RD2 <= x"00000020";  -- Operand B
        RD3 <= x"00000005";  -- Operand C
        sign_extend <= x"0000000F"; -- Sign-extended immediate
        alu_control <= "0001"; -- Example ALU operation (ADD)
        alu_src <= '0';       -- Use RD2 as SrcB
        rt <= "00001";        -- Target register
        rd <= "00010";        -- Destination register
        reg_dst <= '0';       -- Write to RT
        ForwardAE <= "00";    -- No forwarding for A
        ForwardBE <= "00";    -- No forwarding for B
        ForwardCE <= "00";    -- No forwarding for C
        ResultW <= x"00000000"; -- Write-back result
        ALUout <= x"00000000"; -- Previous ALU result
        wait for 20 ns;

        -- Test Case 2: ForwardAE = "01", alu_src = '1'
        ForwardAE <= "01";
        ResultW <= x"00000030"; -- Forwarded value
        alu_src <= '1';         -- Use sign_extend as SrcB
        wait for 20 ns;

        -- Test Case 3: ForwardBE = "10", ForwardCE = "10"
        ForwardBE <= "10";
        ForwardCE <= "10";
        ALUout <= x"00000040"; -- Forwarded value for BE and CE
        wait for 20 ns;

        -- Test Case 4: RegDst = '1' (write to RD)
        reg_dst <= '1';
        wait for 20 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
