library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA_tb is
--  Port ( );
end FA_tb;

architecture Behavioral of FA_tb is
 component FA
 port(      A : in STD_LOGIC;
            B : in STD_LOGIC;
            CIN : in STD_LOGIC;
            s : out STD_LOGIC;
            Cout : out STD_LOGIC);
 
end COMPONENT;

SIGNAL A: STD_LOGIC:= '0';
SIGNAL B: STD_LOGIC:= '0';
SIGNAL CIN: STD_LOGIC:= '0';
SIGNAL S: STD_LOGIC;
SIGNAL Cout: STD_LOGIC;

begin
uut: FA port map(
A=>A,
B=>B,
CIN=>CIN,
s=>s,
Cout=>Cout);

stim_proc: process
begin
A<='1'; B<='1'; CIN<='1'; WAIT FOR 10 ns;
A<='1'; B<='0'; CIN<='1'; WAIT FOR 10 ns;
A<='0'; B<='0'; CIN<='1'; WAIT FOR 10 ns;wait;

end process;
end Behavioral;
