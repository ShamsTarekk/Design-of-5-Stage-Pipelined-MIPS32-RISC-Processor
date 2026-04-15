library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Add_Sub is

port(      A: IN std_logic_vector(31 downto 0);  
           B : IN std_logic_vector(31 downto 0);  
           CIN : IN std_logic;
           sum : OUT std_logic_vector(31 downto 0);
           cout : OUT std_logic);
end Add_Sub;

architecture Behavioral of Add_Sub is

COMPONENT FA
port(      A : in STD_LOGIC;
           B : in STD_LOGIC;
           CIN : in STD_LOGIC;
           s : out STD_LOGIC;
           Cout : out STD_LOGIC);

end COMPONENT;

signal xoring: std_logic_vector(31 downto 0);
signal cr : std_logic_vector (32 downto 0);

Begin
Cr (0) <=CIN;
GEN_ADD: for i in 0 to 31 generate
xoring(i) <= B(i) xor Cr(0);
ADDX: FA port map(A(i),xoring(i),Cr(i), sum(i), Cr(i+1));
end generate GEN_ADD;
Cout <= Cr(32);


end Behavioral;
