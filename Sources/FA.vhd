library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is

port(       A : in STD_LOGIC;
            B : in STD_LOGIC;
            CIN : in STD_LOGIC;
            s : out STD_LOGIC;
            Cout : out STD_LOGIC);

end FA;

architecture Behavioral of FA is

begin

s <= ((not A) AND (NOT B) AND CIN) OR ((not A) AND B AND (NOT CIN)) OR (A AND (NOT B) AND (NOT CIN)) OR (A AND B AND CIN);
COUT <= (B AND CIN) OR (A AND CIN) OR (A AND B);

end Behavioral;
