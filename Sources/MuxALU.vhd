library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxALU is
    Port (
        ALUControl : in std_logic_vector(2 downto 0);  
        add_out    : in std_logic_vector(31 downto 0); 
        sub_out    : in std_logic_vector(31 downto 0); 
        and_out    : in std_logic_vector(31 downto 0); 
        or_out     : in std_logic_vector(31 downto 0); 
        ann_out    : in std_logic_vector(31 downto 0);
        Result     : out std_logic_vector(31 downto 0) 
    );
end MuxALU;

architecture Behavioral of MuxALU is
begin
    Result <= add_out  when ALUControl = "010" else
              sub_out  when ALUControl = "011" else
              and_out  when ALUControl = "100" else
              or_out   when ALUControl = "101" else
              ann_out  when ALUControl = "110" else
              (others => '0'); 
end Behavioral;
