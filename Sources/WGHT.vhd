library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WGHT is
    port (
        input1 : in std_logic_vector(31 downto 0);
        input2 : in std_logic_vector(31 downto 0);
        input3 : in std_logic_vector(31 downto 0);
        enable : in std_logic_vector(2 downto 0);
        clk : in std_logic
        );
end WGHT;

architecture Behavioral of WGHT is
    signal w1_reg, w2_reg, w3_reg : std_logic_vector(31 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if(enable = "111")then
                w1_reg <= input1;
                w2_reg <= input2;
                w3_reg <= input3;
             end if;   
        end if;
    end process;

end Behavioral;
