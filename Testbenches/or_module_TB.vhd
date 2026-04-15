library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_module_TB is
end or_module_TB;

architecture Behavioral of or_module_TB is
  component OR_module
    Port (
      x : in  STD_LOGIC_VECTOR(31 downto 0);
      y : in  STD_LOGIC_VECTOR(31 downto 0);
      put : out STD_LOGIC_VECTOR(31 downto 0) );
  end component;

  SIGNAL X: STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
  SIGNAL Y: STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
  SIGNAL PUT: STD_LOGIC_VECTOR(31 downto 0);
begin
  uut: OR_module port map(
    x => X,
    y => Y,
    put => PUT);
  stim_proc: process
  begin
    X <= "00000000000000000000000000001111";Y <= "00000000000000000000000000001011";WAIT FOR 10 ns;
    X <= "00000000000000000000000000001010";Y <= "00000000000000000000000000000000";WAIT FOR 10 ns;
    X <= "00000000000000000000000000001101";Y <= "00000000000000000000000000000010";WAIT FOR 10 ns; wait;
   end process;
end Behavioral;
