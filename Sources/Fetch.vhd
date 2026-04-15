library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Fetch is
    Port (
        clk             : in std_logic;
        STALLIF         : IN STD_LOGIC; 
        PCSrcD           : in std_logic;
        branch_target   : in std_logic_vector(31 downto 0);    
        next_PC         : out std_logic_vector(31 downto 0);
        RD              : out std_logic_vector(31 downto 0)
    );
end Fetch;

architecture Behavioral of Fetch is

    component instruction_memory is
        Port (
            A : in STD_LOGIC_VECTOR(31 downto 0); -- Address input
            RD : out STD_LOGIC_VECTOR(31 downto 0) -- Instruction output
        );
    end component;

    signal pc_in       : std_logic_vector(31 downto 0):= (others => '0');

begin 

    IM_inst : instruction_memory 
        port map (
            A  => pc_in,
            RD => RD
     );
 
     process(clk)
     begin
        if rising_edge(clk) then
             if STALLIF = '1' then
                 pc_in <= pc_in; -- Hold the current value of pcf
             else
                 if PCSrcD = '1' then
                     pc_in <= branch_target; -- Branch to the address
                 else
                     pc_in <= pc_in + 4; -- Increment the PC
                 end if;
             end if;
         end if;
     end process;
     
     next_PC <= pc_in + 4;

 
 end Behavioral;

