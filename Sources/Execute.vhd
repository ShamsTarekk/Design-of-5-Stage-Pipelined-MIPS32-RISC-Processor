library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Execute is
    port (
        clk                 : in std_logic;
        RD1                 : in std_logic_vector(31 downto 0);
        RD2                 : in std_logic_vector(31 downto 0);
        RD3                 : in std_logic_vector(31 downto 0);
        sign_extend         : in std_logic_vector(31 downto 0);
        alu_control         : in std_logic_vector(2 downto 0);
        alu_src             : in std_logic;
        rt                  : in std_logic_vector(4 downto 0);
        rd                  : in std_logic_vector(4 downto 0);
        reg_dst             : in std_logic;
        ForwardAE           : in std_logic_vector(1 downto 0);
        ForwardBE           : in std_logic_vector(1 downto 0);
        ForwardCE           : in std_logic_vector(1 downto 0);
        ALUout              : in std_logic_vector(31 downto 0);
        ResultW             : in std_logic_vector(31 downto 0);
        alu_result          : out std_logic_vector(31 downto 0);
        write_reg_address   : out std_logic_vector(4 downto 0);
        write_data          : out std_logic_vector(31 downto 0)
    );
end Execute;

architecture Behavioral of Execute is

COMPONENT ALU is
    Port (
        clk:  in std_logic;
        SrcA: in std_logic_vector(31 downto 0);      -- Operand A
        SrcB: in std_logic_vector(31 downto 0);      -- Operand B
        SrcC: in std_logic_vector(31 downto 0);
        ALUControl: in std_logic_vector(2 downto 0); -- ALU operation control signal
        ALUResult: out std_logic_vector(31 downto 0) -- Result of ALU operation
    );
END COMPONENT;

    signal A, B, C, internal_write_data : std_logic_vector(31 downto 0);

begin
    -- Register write address selection
    write_reg_address <= (others => '0') when (reg_dst = '0') else rd;

    process(CLK)
    begin
        if ForwardAE = "00" then
            A <= RD1;
        elsif ForwardAE = "01" then
            A <= ResultW;
        else
            A <= ALUout;
        end if;
        
        if ForwardBE = "00" then
            internal_write_data <= RD2;
        elsif ForwardBE = "01" then
            internal_write_data <= ResultW;
        else
            internal_write_data <= ALUout;
        end if;
        
        if ForwardCE = "00" then
            C <= RD3;
        elsif ForwardCE = "01" then
            C <= ResultW;
        else
            C <= ALUout;
        end if;
        
        if alu_src = '1' then
            B <= sign_extend;
        else
            B <= internal_write_data;
        end if;
    end process;

    -- ALU instantiation
    ALU1 : ALU
        port map (
            clk => clk,
            SrcA => A,
            SrcB => B,
            SrcC => C,
            ALUControl => alu_control,
            ALUResult => alu_result
        );

    -- Assign final value to write_data output
    write_data <= internal_write_data;

end Behavioral;
