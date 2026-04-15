library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity And_module is
    Port ( x : in STD_LOGIC_vector(31 downto 0);
           y : in STD_LOGIC_vector(31 downto 0);
           output : out STD_LOGIC_vector(31 downto 0));
end And_module;

architecture Behavioral of And_module is

begin
    GEN_ADD: for i in 0 to 31 generate
    output(i) <= x(i) and y(i);
    end generate GEN_ADD;
end Behavioral;
