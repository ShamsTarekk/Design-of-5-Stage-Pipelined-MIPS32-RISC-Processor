library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decode is
    port (
        clk : in std_logic;
        regWrite_in : in std_logic;
        writeReg : in std_logic_vector(4 downto 0);
        writeData : in std_logic_vector(31 downto 0);
        instruction : in std_logic_vector(31 downto 0);
        PCplus4ID : in std_logic_vector(31 downto 0); -- External input for PC+4
        ALUout : in std_logic_vector(31 downto 0);
        ForwardAD : in std_logic;
        ForwardBD : in std_logic;

        rs : out std_logic_vector(4 downto 0);
        rt : out std_logic_vector(4 downto 0);
        rd : out std_logic_vector(4 downto 0);
        sign_extended_Imm : out std_logic_vector(31 downto 0);
        PCbranchD : out std_logic_vector(31 downto 0);
        PCbranchShifted : out std_logic_vector(31 downto 0); -- Output for shifted branch address
        RD1 : out std_logic_vector(31 downto 0);
        RD2 : out std_logic_vector(31 downto 0);
        RD3 : out std_logic_vector(31 downto 0);
        PCsrc : out std_logic;
        regDst : out std_logic;
        aluSrc : out std_logic;
        memToReg : out std_logic;
        regWrite_out : out std_logic;
        memWrite : out std_logic;
        aluOp : out std_logic_vector(3 downto 0);
        branchD : out std_logic
    );
end Decode;

architecture Behavioral of Decode is

    component signextend is
        Port (
            A : in STD_LOGIC_VECTOR(15 downto 0);
            SignImm : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Registers is
        Port (
            CLK           : in std_logic;
            WE3           : in std_logic;               -- Write Enable for register 3
            A1, A2, A3    : in std_logic_vector(4 downto 0);  -- Address inputs for reading
            WD3           : in std_logic_vector(31 downto 0); -- Data input to be written
            write_reg     : in std_logic_vector(4 downto 0);  -- Write address input
            RD1, RD2, RD3 : out std_logic_vector(31 downto 0)  -- Data outputs from registers
        );
    end component;

    component control_unit is
        port (
            opcode      : in  std_logic_vector(5 downto 0);
            funct       : in  std_logic_vector(5 downto 0);
            RegWriteD   : out std_logic;
            MemWriteD   : out std_logic;
            MemtoRegD   : out std_logic;
            ALUControlD : out std_logic_vector(2 downto 0);
            ALUSrcD     : out std_logic;
            RegDstD     : out std_logic;
            BranchD     : out std_logic
        );
    end component;

    signal x, y , READ1,READ2: std_logic_vector(31 downto 0);
    signal opcode : std_logic_vector(5 downto 0);
    signal fn : std_logic_vector(5 downto 0);
    SIGNAL branch :std_logic;
    signal Imm : std_logic_vector(15 downto 0);
    signal s, t, d : std_logic_vector(4 downto 0);

    -- Shifting logic
    signal sign_extended_Imm_Shifted, sign_extended : std_logic_vector(31 downto 0);

begin

    -- Extract parts of the instruction
    opcode <= instruction(31 downto 26);
    fn <= instruction(5 downto 0);
    Imm <= instruction(15 downto 0);

    -- rs, rt, rd assignments
    s <= instruction(25 downto 21);
    t <= instruction(20 downto 16);
    d <= instruction(15 downto 11);

    -- Forwarding logic for data
    x <= ALUout when ForwardAD = '1' else READ1;
    y <= ALUout when ForwardBD = '1' else READ2;
    PCsrc <= '1' when (x = y) and branch = '1' else '0';
    
    RD1<=READ1;
    RD2<=READ2; 

    -- Shifting the extended immediate by 2 bits and adding to PCplus4ID
    sign_extended_Imm_Shifted <= sign_extended(31 downto 2) & "00";  -- Shift left by 2 bits
    PCbranchShifted <= PCplus4ID + sign_extended_Imm_Shifted;

    -- Sign extension module instantiation
    Signextender : signextend
        port map (
            A => Imm,
            SignImm => sign_extended
        );
    sign_extended_Imm <= sign_extended;

    -- Registers module instantiation
    regFile : Registers
        port map (
            CLK => clk,
            WE3 => regWrite_in,
            A1 => s,
            A2 => t,
            A3 => d,
            WD3 => writeData,
            write_reg => writeReg,
            RD1 => RD1,
            RD2 => RD2,
            RD3 => RD3
        );
    rs <= s;
    rt <= t;
    rd <= d;

    -- Control unit module instantiation
    controlUnit : control_unit
        port map (
            opcode => opcode,
            funct => fn,
            RegWriteD => regWrite_out,
            MemWriteD => memWrite,
            MemtoRegD => memToReg,
            ALUControlD => aluOp(2 downto 0),
            ALUSrcD => aluSrc,
            RegDstD => regDst,
            BranchD => branch  -- Corrected to connect BranchD output
        );
        BranchD <= branch;

end Behavioral;
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity Decode_stage is
--    generic (
--        REGISTER_LENGTH : integer := 32;
--        HALF_REGISTER_LENGTH : integer := REGISTER_LENGTH / 2 -- 16
--    );
--    port (
--        clk               : in std_logic;
--        regWrite_in       : in std_logic;                       -- enable register write(input)
--        writeReg          : in std_logic_vector(4 downto 0);    -- address to write to
--        writeData         : in std_logic_vector(REGISTER_LENGTH-1 downto 0); -- data we will write in register
--        instruction       : in std_logic_vector(REGISTER_LENGTH-1 downto 0); -- instruction from fetch stage
--        PCplus1_D         : in std_logic_vector(REGISTER_LENGTH-1 downto 0); -- PC counter
--        ALUout            : in std_logic_vector(REGISTER_LENGTH-1 downto 0);
--        ForwardAD         : in std_logic;
--        ForwardBD         : in std_logic;
        
--        rs                : out std_logic_vector(4 downto 0);
--        rt                : out std_logic_vector(4 downto 0);
--        rd                : out std_logic_vector(4 downto 0);
--        sign_extended_Imm : out std_logic_vector(REGISTER_LENGTH-1 downto 0); -- immediate after extension
--        PCbranchD         : out std_logic_vector(REGISTER_LENGTH-1 downto 0);
--        readData1         : out std_logic_vector(REGISTER_LENGTH-1 downto 0); -- Read data 1 from register file
--        readData2         : out std_logic_vector(REGISTER_LENGTH-1 downto 0); -- Read data 2 from register file
--        readData3         : out std_logic_vector(REGISTER_LENGTH-1 downto 0); -- Read data 3 from register file
--        PCsrc             : out std_logic;                       -- Branch control
--        regDst            : out std_logic;                       -- register destination rt wala rd
--        aluSrc            : out std_logic;                       -- register wala immediate
--        memToReg          : out std_logic;                       -- alu result or memory
--        regWrite_out      : out std_logic;                       -- register write enable(output)
--        memWrite          : out std_logic;                       -- Memory write enable
--        aluOp             : out std_logic_vector(3 downto 0);    -- ALU operation type
--        branchD           : out std_logic
--    );
--end Decode_stage;

--architecture Behavioral of Decode_stage is

--    signal BranchD          : std_logic;
--    signal m1, m2           : std_logic_vector(REGISTER_LENGTH-1 downto 0);
--    signal opcode           : std_logic_vector(5 downto 0);
--    signal fn               : std_logic_vector(5 downto 0);
--    signal Imm              : std_logic_vector(HALF_REGISTER_LENGTH-1 downto 0);

--    -- Intermediate signals
--    signal sign_extended_Imm_internal : std_logic_vector(REGISTER_LENGTH-1 downto 0);

--begin

--    -- Assign the opcode and function code from the instruction
--    opcode <= instruction(31 downto 26);
--    fn <= instruction(5 downto 0);
--    Imm <= instruction(HALF_REGISTER_LENGTH-1 downto 0);

--    -- Assign outputs for rs, rt, and rd
--    rs <= instruction(25 downto 21);
--    rt <= instruction(20 downto 16);
--    rd <= instruction(15 downto 11);

--    -- Forwarding logic for readData1 and readData2 based on forwarding signals
--    m1 <= (others => '0'); -- Default value for m1
--    m2 <= (others => '0'); -- Default value for m2
--    m1 <= (others => '0') when ForwardAD = '0' else ALUout;
--    m2 <= (others => '0') when ForwardBD = '0' else ALUout;

--    -- Branch condition check for PCsrc
--    PCsrc <= '1' when (m1 = m2) and BranchD = '1' else '0';

--    -- Calculate PCbranchD
--    PCbranchD <= std_logic_vector(unsigned(PCplus1_D) + unsigned(sign_extended_Imm_internal));

--    -- Sign extension logic
--    Signextender : entity work.Signextend
--        generic map (
--            REGISTER_LENGTH => REGISTER_LENGTH
--        )
--        port map (
--            in => Imm,
--            out => sign_extended_Imm_internal
--        );

--    -- Registers (Register file)
--    regFile : entity work.Registers
--        generic map (
--            REGISTER_LENGTH => REGISTER_LENGTH
--        )
--        port map (
--            clk => clk,
--            reg_write => regWrite_in,
--            read_reg1 => rs,
--            read_reg2 => rt,
--            read_reg3 => rd,
--            write_reg => writeReg,
--            write_data => writeData,
--            read_data1 => readData1,
--            read_data2 => readData2,
--            read_data3 => readData3
--        );

--    -- Control unit logic
--    controlUnit : entity work.control_unit
--        port map (
--            opcode => opcode,
--            funct => fn,
--            alu_src => aluSrc,
--            reg_dst => regDst,
--            mem_to_reg => memToReg,
--            reg_write => regWrite_out,
--            mem_write => memWrite,
--            branch => BranchD,
--            alu_op => aluOp
--        );

--end Behavioral;
