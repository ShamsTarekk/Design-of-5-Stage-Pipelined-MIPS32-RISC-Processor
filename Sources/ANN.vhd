library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ANN is
    port (
        input1 : in std_logic_vector(31 downto 0);
        input2 : in std_logic_vector(31 downto 0);
        w1_reg : in std_logic_vector(31 downto 0);
        w2_reg : in std_logic_vector(31 downto 0);
        w3_reg : in std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0)
    );
end ANN;

architecture Behavioral of ANN is

    SIGNAL Rd,rd2,result2 : std_logic_vector(31 downto 0):=(others =>'0');

begin

--    Rd <= (input1 * w1_reg) + (input2 * w2_reg);
--    rd2 <= (((input1 * w1_reg) + (input2 * w2_reg)) * w3_reg);
--    result2 <= Rd + rd2;
--    result <= result2;
    
end Behavioral;
