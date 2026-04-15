library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtend_TB is
end SignExtend_TB;

architecture Behavioral of SignExtend_TB is

    component SignExtend
        Port (
            A : in STD_LOGIC_VECTOR(15 downto 0);
            SignImm : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;  
    
    signal A : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal SignImm : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin

    uut: SignExtend
        Port map (
            A => A,
            SignImm => SignImm
        );

    stimulus_process: process
    begin
        A <= "0000000000001010";
        wait for 10 ns;
        A <= "1111111111111010";
        wait for 10 ns;
        A <= "0000000000000000";
        wait for 10 ns;
        A <= "1111111111111111";
        wait for 10 ns;
        A <= "0000000000001100";
        wait for 10 ns;
        A <= "1111111111110001";
        wait for 10 ns;
        wait;
    end process;

end Behavioral;
