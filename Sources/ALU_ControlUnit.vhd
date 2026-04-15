library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
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
end control_unit;

architecture Behavioral of control_unit is

    -- Parameters for opcode and funct values
    constant R_TYPE      : std_logic_vector(5 downto 0) := "000000";  -- R-Type opcode
    constant LW          : std_logic_vector(5 downto 0) := "100000";  -- LW opcode
    constant SW          : std_logic_vector(5 downto 0) := "100001";  -- SW opcode
    constant BEQZ        : std_logic_vector(5 downto 0) := "100010";  -- BEQZ opcode
    constant ADDI        : std_logic_vector(5 downto 0) := "100011";  -- ADDI opcode
    constant SUBI        : std_logic_vector(5 downto 0) := "100100";  -- SUBI opcode
    constant WGHT        : std_logic_vector(5 downto 0) := "100110";  -- WGHT opcode
    
    -- ALU control parameters (3-bit ALU control)
    constant ADD_ALU     : std_logic_vector(2 downto 0) := "010";  -- ADD ALU control
    constant SUB_ALU     : std_logic_vector(2 downto 0) := "011";  -- SUB ALU control
    constant AND_ALU     : std_logic_vector(2 downto 0) := "100";  -- AND ALU control
    constant OR_ALU      : std_logic_vector(2 downto 0) := "101";  -- OR ALU control
    constant ANN_ALU     : std_logic_vector(2 downto 0) := "110";  -- ANN ALU control
    constant WGHT_ALU    : std_logic_vector(2 downto 0) := "111";  -- WGHT ALU control
    
    -- Function control parameters for R-Type instructions
    constant ADD_FUNCTION : std_logic_vector(5 downto 0) := "111111";  -- ADD funct
    constant SUB_FUNCTION : std_logic_vector(5 downto 0) := "111110";  -- SUB funct
    constant AND_FUNCTION : std_logic_vector(5 downto 0) := "111100";  -- AND funct
    constant OR_FUNCTION  : std_logic_vector(5 downto 0) := "111000";  -- OR funct
    constant ANN_FUNCTION : std_logic_vector(5 downto 0) := "110000";  -- ANN funct

begin
    process (opcode, funct)
    begin
        -- Default values for control signals
        RegWriteD   <= '0';
        MemWriteD   <= '0';
        MemtoRegD   <= '0';
        ALUControlD <= ADD_ALU;      -- Default ALU operation is ADD
        ALUSrcD     <= '0';          -- Default ALU source is from registers
        RegDstD     <= '0';          -- Default destination register is rt
        BranchD     <= '0';          -- Default no branching

        -- Control Logic with if-else statements
        if opcode = R_TYPE then
            RegDstD     <= '1';             -- Write to rd
            RegWriteD   <= '1';             -- Register write enable
            if funct = ADD_FUNCTION then
                ALUControlD <= ADD_ALU;   -- ADD operation
            elsif funct = SUB_FUNCTION then
                ALUControlD <= SUB_ALU;   -- SUB operation
            elsif funct = AND_FUNCTION then
                ALUControlD <= AND_ALU;   -- AND operation
            elsif funct = OR_FUNCTION then
                ALUControlD <= OR_ALU;    -- OR operation
            elsif funct = ANN_FUNCTION then
                ALUControlD <= ANN_ALU;   -- ANN operation
            else
                ALUControlD <= ADD_ALU;   -- Default to ADD operation
            end if;
            
        elsif opcode = LW then
            ALUControlD <= ADD_ALU;         -- ADD to calculate address
            ALUSrcD     <= '1';             -- ALU source is immediate
            MemtoRegD   <= '1';             -- Load from memory to register
            RegWriteD   <= '1';             -- Register write enable
            
        elsif opcode = SW then
            ALUControlD <= ADD_ALU;         -- ADD to calculate address
            ALUSrcD     <= '1';             -- ALU source is immediate
            MemWriteD   <= '1';             -- Memory write enable
            
        elsif opcode = BEQZ then
            ALUControlD <= SUB_ALU;         -- SUB to compare with zero
            BranchD     <= '1';             -- Branch control
            
        elsif opcode = ADDI then
            ALUControlD <= ADD_ALU;         -- ADD operation
            ALUSrcD     <= '1';             -- ALU source is immediate
            RegWriteD   <= '1';             -- Register write enable
            
        elsif opcode = SUBI then
            ALUControlD <= SUB_ALU;         -- SUB operation
            ALUSrcD     <= '1';             -- ALU source is immediate
            RegWriteD   <= '1';             -- Register write enable
            
        elsif opcode = WGHT then
            ALUControlD <= WGHT_ALU;        -- WGHT operation
            
        else
            ALUControlD <= ADD_ALU;
            RegWriteD   <= '0';
            MemWriteD   <= '0';
            BranchD     <= '0';
        end if;
    end process;

end Behavioral;
