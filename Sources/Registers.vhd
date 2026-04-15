library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity Registers is
  Port (
    CLK           : in std_logic;
    WE3           : in std_logic;               -- Write Enable for register 3
    A1, A2, A3    : in std_logic_vector(4 downto 0);  -- Address inputs for reading
    WD3           : in std_logic_vector(31 downto 0); -- Data input to be written
    write_reg     : in std_logic_vector(4 downto 0);  -- Write address input
    RD1, RD2, RD3 : out std_logic_vector(31 downto 0)  -- Data outputs from registers
  );
end Registers;

architecture Behavioral of Registers is
    type ram is array(0 to 31) of std_logic_vector(31 downto 0);
    signal regfile : ram := (others => (others => '0')); 
begin
    
    RD1 <= regfile(to_integer(unsigned(A1)));  -- Read from A1
    RD2 <= regfile(to_integer(unsigned(A2)));  -- Read from A2
    RD3 <= regfile(to_integer(unsigned(A3)));  -- Read from A3

    PROCESS(CLK)
    BEGIN
        if rising_edge(CLK) then
            if WE3 = '1' and write_reg /= "00000" then
                regfile(to_integer(unsigned(write_reg))) <= WD3;
            end if;
        end if;
    END PROCESS;
end Behavioral;
