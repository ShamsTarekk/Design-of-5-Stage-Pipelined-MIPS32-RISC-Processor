library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signextend is
    Port (
        A : in STD_LOGIC_VECTOR(15 downto 0);
        SignImm : out STD_LOGIC_VECTOR(31 downto 0)
    );
end signextend;

architecture Behavioral of signextend is
begin

    SignImm(15 downto 0)<=A(15 downto 0);

    with A(15) select		  
    SignImm(31 downto 16) <= x"FFFF" when '1',
                             x"0000" when others;
end Behavioral;
