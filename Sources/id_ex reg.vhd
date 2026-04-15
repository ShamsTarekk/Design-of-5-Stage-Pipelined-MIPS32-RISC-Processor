library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity id_ex_reg is
  Port (
         -- Inputs
         CLK : IN STD_LOGIC;
         FlushE : IN STD_LOGIC; -- Flush signal
         RegWriteD : IN STD_LOGIC;
         MemtoRegD : IN STD_LOGIC;
         MemWriteD : IN STD_LOGIC;
         ALUControlD : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         ALUSrcD : IN STD_LOGIC;
         RegDstD: IN STD_LOGIC;
         RD1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         RD2: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         RD3: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         rsD: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
         rtD: IN STD_LOGIC_VECTOR(4 DOWNTO 0);       
         rdD: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
         SignImmD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         -- Outputs
         RegWriteE: OUT STD_LOGIC;
         MemtoRegE: OUT STD_LOGIC;
         MemWriteE: OUT STD_LOGIC;
         ALUControlE: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
         ALUSrcE: OUT STD_LOGIC;
         RegDstE: OUT STD_LOGIC;
         RD1E: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         RD2E: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         RD3E: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         rsE: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
         rtE: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
         rdE: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
         SignImmE: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
         );
end id_ex_reg;

architecture Behavioral of id_ex_reg is
begin

    -- Process to handle the pipeline register behavior
    process(CLK)
    begin
        if rising_edge(CLK) then
            if FlushE = '1' then
                -- Clear all registers when FlushE is high
                RegWriteE <= '0';
                MemtoRegE <= '0';
                MemWriteE <= '0';
                ALUControlE <= (others => '0');
                ALUSrcE <= '0';
                RegDstE <= '0';
                RD1E <= (others => '0');
                RD2E <= (others => '0');
                RD3E <= (others => '0');
                rsE <= (others => '0');
                rtE <= (others => '0');
                rdE <= (others => '0');
                SignImmE <= (others => '0');
            else
                -- Update registers with inputs when FlushE is low
                RegWriteE <= RegWriteD;
                MemtoRegE <= MemtoRegD;
                MemWriteE <= MemWriteD;
                ALUControlE <= ALUControlD;
                ALUSrcE <= ALUSrcD;
                RegDstE <= RegDstD;
                RD1E <= RD1;
                RD2E <= RD2;
                RD3E <= RD3;
                rsE <= rsD;
                rtE <= rtD;
                rdE <= rdD;
                SignImmE <= SignImmD;
            end if;
        end if;
    end process;

end Behavioral;
