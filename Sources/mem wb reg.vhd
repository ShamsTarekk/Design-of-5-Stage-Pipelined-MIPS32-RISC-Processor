library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mem_WB_reg is
    port (
        clk                : in  std_logic;
        RDM        : in  std_logic_vector(31 downto 0);  -- Memory data input
        ALUOutM      : in  std_logic_vector(31 downto 0);  -- ALU result from MEM stage
        WriteRegM  : in  std_logic_vector(4 downto 0);     -- Write register address from MEM stage
        RegWriteM : in  std_logic;                          -- RegWrite control signal
        MemtoRegM       : in  std_logic;                    -- MemtoReg control signal
        
        RDW       : out std_logic_vector(31 downto 0);      -- Memory data output
        ALUOutW      : out std_logic_vector(31 downto 0);   -- ALU result output
        WriteRegW : out std_logic_vector(4 downto 0);       -- Write register address output
        RegWriteW : out std_logic;                          -- RegWrite control output
        MemtoRegW     : out std_logic                        -- MemtoReg control output
    );
end Mem_WB_reg;

architecture Behavioral of Mem_WB_reg is
begin

  process(clk)
  begin
    if rising_edge(clk) then
      -- Transfer the inputs to the outputs on the rising edge of the clock
      RDW       <= RDM;
      ALUOutW   <= ALUOutM;
      WriteRegW <= WriteRegM;
      RegWriteW <= RegWriteM;
      MemtoRegW <= MemtoRegM;
    end if;
  end process;

end Behavioral;
