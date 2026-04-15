library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex_mem_reg is
  Port (
    -- Input ports
    clk          : in  std_logic;
    RegWriteE    : in  std_logic;
    MemtoRegE    : in  std_logic;
    MemWriteE    : in  std_logic;
    ALUoutE      : in  std_logic_vector(31 downto 0);
    WriteDataE   : in  std_logic_vector(31 downto 0);
    WriteRegE    : in  std_logic_vector(4 downto 0);
    -- Output ports
    RegWriteM    : out std_logic;
    MemtoRegM    : out std_logic;
    MemWriteM    : out std_logic;
    ALUoutM      : out std_logic_vector(31 downto 0);
    WriteDataM   : out std_logic_vector(31 downto 0);
    WriteRegM    : out std_logic_vector(4 downto 0)
  );
end ex_mem_reg;

architecture Behavioral of ex_mem_reg is
begin

  process(clk)
  begin
    if rising_edge(clk) then
      RegWriteM    <= RegWriteE;
      MemtoRegM    <= MemtoRegE;
      MemWriteM    <= MemWriteE;
      ALUoutM      <= ALUoutE;
      WriteDataM   <= WriteDataE;
      WriteRegM    <= WriteRegE;
    end if;
  end process;

end Behavioral;
