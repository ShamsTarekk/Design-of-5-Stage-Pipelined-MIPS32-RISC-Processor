library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity Memory is
   Port (clk : in std_logic;
         WE : in std_logic;                -- Write enable
         A : in std_logic_vector(31 downto 0); -- Address
         WD : in std_logic_vector(31 downto 0); -- Write data
         RD : out std_logic_vector(31 downto 0) -- Read data
        );
end Memory;

architecture Behavioral of Memory is

    TYPE ram IS ARRAY (0 TO 255) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL dmem: ram := (others => (others => '0'));

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (WE = '1') then
                dmem(to_integer(unsigned(A(31 downto 2)))) <= WD; -- data write store
            elsif(WE='0') then
                RD <= dmem(to_integer(unsigned(A(31 downto 2)))); -- data read load
            end if;
        end if;
    end process;

end Behavioral;
