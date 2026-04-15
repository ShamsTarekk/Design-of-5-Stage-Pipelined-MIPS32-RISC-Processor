library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR_module is
    Port ( 
        x : in STD_LOGIC_VECTOR(31 downto 0);
        y : in STD_LOGIC_VECTOR(31 downto 0);
        put : out STD_LOGIC_VECTOR(31 downto 0)
    );
end OR_module;

architecture Behavioral of OR_module is
begin
    GEN_ADD: for i in 0 to 31 generate
    put(i) <= x(i) or y(i);
    end generate GEN_ADD;
    
end Behavioral;
