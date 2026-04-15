library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decode_tb is
end Decode_tb;

architecture Behavioral of Decode_tb is

    -- Declare component to be tested
    component Decode is
        port (
            clk : in std_logic;
            regWrite_in : in std_logic;
            writeReg : in std_logic_vector(4 downto 0);
            writeData : in std_logic_vector(31 downto 0);
            instruction : in std_logic_vector(31 downto 0);
            PCplus4ID : in std_logic_vector(31 downto 0);
            ALUout : in std_logic_vector(31 downto 0);
            ForwardAD : in std_logic;
            ForwardBD : in std_logic;

            rs : out std_logic_vector(4 downto 0);
            rt : out std_logic_vector(4 downto 0);
            rd : out std_logic_vector(4 downto 0);
            sign_extended_Imm : out std_logic_vector(31 downto 0);
            PCbranchD : out std_logic_vector(31 downto 0);
            PCbranchShifted : out std_logic_vector(31 downto 0);
            RD1 : out std_logic_vector(31 downto 0);
            RD2 : out std_logic_vector(31 downto 0);
            RD3 : out std_logic_vector(31 downto 0);
            PCsrc : out std_logic;
            regDst : out std_logic;
            aluSrc : out std_logic;
            memToReg : out std_logic;
            regWrite_out : out std_logic;
            memWrite : out std_logic;
            aluOp : out std_logic_vector(3 downto 0);
            branchD : out std_logic
        );
    end component;

    -- Testbench signals
    signal clk : std_logic := '0';
    signal regWrite_in : std_logic := '0';
    signal writeReg : std_logic_vector(4 downto 0) := "00000";
    signal writeData : std_logic_vector(31 downto 0) := (others => '0');
    signal instruction : std_logic_vector(31 downto 0) := (others => '0');
    signal PCplus4ID : std_logic_vector(31 downto 0) := (others => '0');
    signal ALUout : std_logic_vector(31 downto 0) := (others => '0');
    signal ForwardAD : std_logic := '0';
    signal ForwardBD : std_logic := '0';

    signal rs, rt, rd : std_logic_vector(4 downto 0);
    signal sign_extended_Imm : std_logic_vector(31 downto 0);
    signal PCbranchD : std_logic_vector(31 downto 0);
    signal PCbranchShifted : std_logic_vector(31 downto 0);
    signal RD1, RD2, RD3 : std_logic_vector(31 downto 0);
    signal PCsrc : std_logic;
    signal regDst, aluSrc, memToReg, regWrite_out, memWrite : std_logic;
    signal aluOp : std_logic_vector(3 downto 0);
    signal branchD : std_logic;


begin
    -- Clock generation process
process
begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
end process;

    -- Instantiate the Decode component
    uut: Decode
        port map (
            clk => clk,
            regWrite_in => regWrite_in,
            writeReg => writeReg,
            writeData => writeData,
            instruction => instruction,
            PCplus4ID => PCplus4ID,
            ALUout => ALUout,
            ForwardAD => ForwardAD,
            ForwardBD => ForwardBD,
            rs => rs,
            rt => rt,
            rd => rd,
            sign_extended_Imm => sign_extended_Imm,
            PCbranchD => PCbranchD,
            PCbranchShifted => PCbranchShifted,
            RD1 => RD1,
            RD2 => RD2,
            RD3 => RD3,
            PCsrc => PCsrc,
            regDst => regDst,
            aluSrc => aluSrc,
            memToReg => memToReg,
            regWrite_out => regWrite_out,
            memWrite => memWrite,
            aluOp => aluOp,
            branchD => branchD
        );

    -- Test process
    process
    begin
        -- Apply some test cases
        
        -- Test 1: Load Word (LW) instruction
        instruction <= "10001100001000110000000000000000";  -- LW instruction with rs = 1, rt = 2, address = 0
        PCplus4ID <= "00000000000000000000000000001000"; -- PC+4 = 8
        wait for 20 ns;
        
        -- Test 2: Add (R-Type) instruction
        instruction <= "00000000001000110001000000100000";  -- R-type ADD with rs = 1, rt = 2, rd = 3
        wait for 20 ns;

        -- Test 3: Branch (BEQZ) instruction
        instruction <= "00010000000000000000000000000000";  -- BEQZ (branch equal zero)
        wait for 20 ns;

        -- Test 4: Immediate ADD (ADDI) instruction
        instruction <= "00100000000000010000000000000100";  -- ADDI with rs = 1, rt = 2, immediate = 4
        wait for 20 ns;

        -- End the simulation
        wait;
    end process;
    
end Behavioral;
