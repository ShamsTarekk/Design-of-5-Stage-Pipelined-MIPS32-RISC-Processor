library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Write_back is

    port(
        MemtoRegW:in std_logic;
        ReadDataW :in std_logic_vector(31 downto 0);
        AlUOutW : in std_logic_vector(31 downto 0);
        ResultW : out std_logic_vector(31 downto 0)
       );
    
end Write_back;

architecture Behavioral of Write_back is

begin

    ResultW <= ReadDataW  when MemtoRegW = '1' else
               AlUOutW  when MemtoRegW = '0' else
              (others => '0');

end Behavioral;
