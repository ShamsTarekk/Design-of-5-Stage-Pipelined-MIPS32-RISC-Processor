library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Registers is
    -- No ports for the testbench
end tb_Registers;

architecture Behavioral of tb_Registers is

    -- Component declaration for the Unit Under Test (UUT)
    component Registers
        port (
            CLK           : in std_logic;
            WE3           : in std_logic;               
            A1, A2, A3    : in std_logic_vector(4 downto 0);  
            WD3           : in std_logic_vector(31 downto 0); 
            write_reg     : in std_logic_vector(4 downto 0);  
            RD1, RD2, RD3 : out std_logic_vector(31 downto 0)  
        );
    end component;

    -- Signals to connect to UUT
    signal CLK           : std_logic := '0';
    signal WE3           : std_logic := '0';
    signal A1, A2, A3    : std_logic_vector(4 downto 0) := (others => '0');
    signal WD3           : std_logic_vector(31 downto 0) := (others => '0');
    signal write_reg     : std_logic_vector(4 downto 0) := (others => '0');
    signal RD1, RD2, RD3 : std_logic_vector(31 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the UUT
    uut: Registers
        port map (
            CLK => CLK,
            WE3 => WE3,
            A1 => A1,
            A2 => A2,
            A3 => A3,
            WD3 => WD3,
            write_reg => write_reg,
            RD1 => RD1,
            RD2 => RD2,
            RD3 => RD3
        );

    -- Clock generation
    clk_process : process
    begin
        while True loop
            CLK <= '0';
            wait for clk_period / 2;
            CLK <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Test Case 1: Write and read from register 1
        WE3 <= '1';
        write_reg <= "00001";           -- Write to register 1
        WD3 <= x"12345678";             -- Data to be written
        wait for clk_period;           -- Wait for one clock cycle
        WE3 <= '0';                    -- Disable write
        A1 <= "00001";                 -- Read from register 1
        wait for clk_period;           -- Wait for one clock cycle
        assert RD1 = x"12345678" report "Test Case 1 Failed!" severity error;

        -- Test Case 2: Write and read from register 2
        WE3 <= '1';
        write_reg <= "00010";           -- Write to register 2
        WD3 <= x"87654321";             -- Data to be written
        wait for clk_period;           -- Wait for one clock cycle
        WE3 <= '0';                    -- Disable write
        A2 <= "00010";                 -- Read from register 2
        wait for clk_period;           -- Wait for one clock cycle
        assert RD2 = x"87654321" report "Test Case 2 Failed!" severity error;

        -- Test Case 3: Write and read from register 3
        WE3 <= '1';
        write_reg <= "00011";           -- Write to register 3
        WD3 <= x"ABCDEF01";             -- Data to be written
        wait for clk_period;           -- Wait for one clock cycle
        WE3 <= '0';                    -- Disable write
        A3 <= "00011";                 -- Read from register 3
        wait for clk_period;           -- Wait for one clock cycle
        assert RD3 = x"ABCDEF01" report "Test Case 3 Failed!" severity error;

        -- Test Case 4: Write to a non-zero register and ensure others are unaffected
        WE3 <= '1';
        write_reg <= "00101";           -- Write to register 5
        WD3 <= x"FEDCBA98";             -- Data to be written
        wait for clk_period;           -- Wait for one clock cycle
        WE3 <= '0';                    -- Disable write
        A1 <= "00001";                 -- Read from register 1 (should remain unchanged)
        A2 <= "00010";                 -- Read from register 2 (should remain unchanged)
        A3 <= "00101";                 -- Read from register 5 (should contain new value)
        wait for clk_period;           -- Wait for one clock cycle
        assert RD1 = x"12345678" report "Test Case 4 Failed for RD1!" severity error;
        assert RD2 = x"87654321" report "Test Case 4 Failed for RD2!" severity error;
        assert RD3 = x"FEDCBA98" report "Test Case 4 Failed for RD3!" severity error;

        -- End simulation
        wait;
    end process;

end Behavioral;
