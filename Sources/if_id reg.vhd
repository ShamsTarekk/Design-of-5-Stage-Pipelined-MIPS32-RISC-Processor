library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IF_ID_reg is
    port (
        clk         : in std_logic;
        stallD      : in std_logic; -- Stall signal
        RD          : in std_logic_vector(31 downto 0); -- Instruction fetched
        PCplus4IF   : in std_logic_vector(31 downto 0); -- PC + 4 from IF stage
        PCsrcD      : in std_logic; -- Branch control signal
        PCplus4ID   : out std_logic_vector(31 downto 0); -- PC + 4 to ID stage
        Instr_ID    : out std_logic_vector(31 downto 0) -- Instruction to ID stage
    );
end IF_ID_reg;

architecture Behavioral of IF_ID_reg is
    signal InstrReg : std_logic_vector(31 downto 0) := (others => '0');
    signal PCReg    : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if PCsrcD = '1' then
                -- Clear the pipeline registers if a branch is taken
                InstrReg <= (others => '0');
                PCReg <= (others => '0');
            elsif stallD = '0' then
                -- Load new values when there's no stall
                InstrReg <= RD;
                PCReg <= PCplus4IF;
            end if;
        end if;
    end process;

    -- Assign outputs
    PCplus4ID <= PCReg;
    Instr_ID <= InstrReg;

end Behavioral;
