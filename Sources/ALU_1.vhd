library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port (
        clk:  in std_logic;
        SrcA: in std_logic_vector(31 downto 0);      -- Operand A
        SrcB: in std_logic_vector(31 downto 0);      -- Operand B
        SrcC: in std_logic_vector(31 downto 0);
        ALUControl: in std_logic_vector(2 downto 0); -- ALU operation control signal
        ALUResult: out std_logic_vector(31 downto 0) -- Result of ALU operation
    );
end ALU;

architecture Behavioral of ALU is

    component Add_sub is
        Port(      
            A: IN std_logic_vector(31 downto 0);  
            B : IN std_logic_vector(31 downto 0);  
            CIN : IN std_logic;
            sum : OUT std_logic_vector(31 downto 0);
            cout : OUT std_logic
        );
    end component;

    component OR_module is
        Port (
            x : in STD_LOGIC_VECTOR(31 downto 0);
            y : in STD_LOGIC_VECTOR(31 downto 0);
            put : out STD_LOGIC_VECTOR(31 downto 0) 
        );
    end component;

    component And_module is
        Port (     
            x : in STD_LOGIC_vector(31 downto 0);
            y : in STD_LOGIC_vector(31 downto 0);
            output : out STD_LOGIC_vector(31 downto 0)
        );
    end component;

    component MuxALU is
        Port (
            ALUControl : in std_logic_vector(2 downto 0);
            add_out    : in std_logic_vector(31 downto 0);
            sub_out    : in std_logic_vector(31 downto 0);
            and_out    : in std_logic_vector(31 downto 0);
            or_out     : in std_logic_vector(31 downto 0);
            ann_out    : in std_logic_vector(31 downto 0);  
            Result     : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component ANN is
        port (
            input1 : in std_logic_vector(31 downto 0);
            input2 : in std_logic_vector(31 downto 0);
            w1_reg : in std_logic_vector(31 downto 0);
            w2_reg : in std_logic_vector(31 downto 0);
            w3_reg : in std_logic_vector(31 downto 0);
            result : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component WGHT is
        port (
            input1 : in std_logic_vector(31 downto 0);
            input2 : in std_logic_vector(31 downto 0);
            input3 : in std_logic_vector(31 downto 0);
            enable : in std_logic_vector(2 downto 0);
            clk : in std_logic
            );
    end component;

    signal add_out, sub_out, and_out, or_out, ann_out: std_logic_vector(31 downto 0):=(others =>'0');
    signal result_internal: std_logic_vector(31 downto 0);
    signal zero:std_logic;
    signal w1_reg ,w2_reg ,w3_reg : std_logic_vector(31 downto 0);
    
begin

    uut1: OR_module port map (x => SrcA, y => SrcB, put => or_out);
    uut2: And_module port map (x => SrcA, y => SrcB, output => and_out);
    uut3: Add_sub port map (A => SrcA, B => SrcB, CIN => '0', sum => add_out, cout => open);
    uut4: Add_sub port map (A => SrcA, B => SrcB, CIN => '1', sum => sub_out, cout => open);
    uut5: WGHT PORT MAP(input1 => SrcA, input2 => SrcB, input3 => SrcA , enable => ALUControl, clk => clk);
    uut6: ANN port map(input1 => SrcA,input2 => SrcB,w1_reg => w1_reg,w2_reg => w2_reg,w3_reg => w3_reg,result => ann_out);
    uut7: MuxALU port map (
        ALUControl => ALUControl,
        add_out    => add_out,
        sub_out    => sub_out,
        and_out    => and_out,
        or_out     => or_out, 
        ann_out    => ann_out,
        Result     => result_internal
    );

    w1_reg <=SrcA;
    w2_reg <=SrcB;
    w3_reg <=SrcC;
    ALUResult <= result_internal;
    Zero <= '1' when result_internal = x"00000000" else '0';

end Behavioral;

