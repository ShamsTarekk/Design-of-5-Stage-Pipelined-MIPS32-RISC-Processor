library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity And_module_TB is
end And_module_TB;

architecture Behavioral of And_module_TB is
  component And_module
    Port (
      x : in  STD_LOGIC_VECTOR(31 downto 0);
      y : in  STD_LOGIC_VECTOR(31 downto 0);
      output : out STD_LOGIC_VECTOR(31 downto 0) );
  end component;

  SIGNAL X: STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
  SIGNAL Y: STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
  SIGNAL OUTPUT: STD_LOGIC_VECTOR(31 downto 0);
begin
  uut: And_module port map(
    x => X,
    y => Y,
    output => OUTPUT);
  stim_proc: process
  begin
    X <= "00000000000000000000000000001111";Y <= "00000000000000000000000000001011";WAIT FOR 10 ns;
    X <= "00000000000000000000000000001010";Y <= "00000000000000000000000000000000";WAIT FOR 10 ns;
    X <= "00000000000000000000000000001101";Y <= "00000000000000000000000000000010";WAIT FOR 10 ns;
    X <= "00000000000000000000000000001101";Y <= "00000000000000000000000000000010";WAIT ;
   end process;
end Behavioral;
