library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Add_Sub_tb is
--  Port ( );
end Add_Sub_tb;

architecture Behavioral of Add_Sub_tb is

component Add_sub 

port(      A : in STD_LOGIC_VECTOR(31 downto 0);
           B : in STD_LOGIC_VECTOR(31 downto 0);
           CIN : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR(31 downto 0);
           Cout : out STD_LOGIC);
end component;

SIGNAL A: STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
SIGNAL B: STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
signal cin : std_logic := '0';
signal sum : std_logic_vector(31 downto 0); 
signal cout : std_logic;

begin
uut: Add_sub port map(A=>A,B=>B,CIN=>CIN,sum=>sum,Cout=>Cout);

stim_proc: process
begin
cin <= '1';
A <= "00000000000000000000000000000001"; B <= "00000000000000000000000000000110"; wait for 10 ns;
A <= "00000000000000000000000000001001"; B <= "00000000000000000000000000000110"; wait for 10 ns; 
cin <= '0';
A <= "00000000000000000000000000000001"; B <= "00000000000000000000000000000011"; wait for 10 ns; 
A <= "00000000000000000000000000000101"; B <= "00000000000000000000000000000010"; wait;
end process;

end Behavioral;