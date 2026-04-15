library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
USE IEEE.NUMERIC_STD.ALL;     
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity instruction_memory is
    Port (
        A  : in STD_LOGIC_VECTOR(31 downto 0); -- Address input 
        RD : out STD_LOGIC_VECTOR(31 downto 0) -- Instruction output 
    );
end instruction_memory;

architecture Behavioral of instruction_memory is
    -- Define memory as an array of 32-bit words (256 entries for simplicity)
    type memory_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    
    -- Signal declaration for the instruction memory, initialized with some instructions
    signal memory : memory_array := (
            0   => x"00000020",  -- ADD $t0, $t1, $t2 
            4   => x"00000022",  -- SUB $t0, $t1, $t2 
            8   => x"21310004",  -- ADDI $t0, $t1, 4 
            12  => x"21310004",  -- SUBI $t0, $t1, 4 
            16  => x"00000024",  -- AND $t0, $t1, $t2
            20  => x"00000025",  -- OR $t0, $t1, $t2 
            24  => x"8D200008",  -- LW $t0, 4($t1) 
            28  => x"AD200004",  -- SW $t0, 4($t1) 
            32  => x"00000026",  -- ANN $t0, $t1, $t2 
            36  => x"01822018",  -- WGHT $t0, $t1, $t2
            40  => x"11000004",  -- BEQZ $t0, $zero, 4
            others => (others => '0')  -- Default all other locations to zero (unused memory locations)
    );
    
begin
    -- Output the instruction stored in memory at the address A
    RD <= memory(CONV_INTEGER(A));  -- Convert the address input 'A' to an integer and use it to access memory
end Behavioral;
