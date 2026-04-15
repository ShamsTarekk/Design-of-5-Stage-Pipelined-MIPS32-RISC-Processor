library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ANN is
    -- Testbench has no ports
end tb_ANN;

architecture Behavioral of tb_ANN is

    -- Component declaration for the Unit Under Test (UUT)
    component ANN
        port (
            input1 : in std_logic_vector(31 downto 0);
            input2 : in std_logic_vector(31 downto 0);
            w1_reg : in std_logic_vector(31 downto 0);
            w2_reg : in std_logic_vector(31 downto 0);
            w3_reg : in std_logic_vector(31 downto 0);
            result : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal input1, input2 : std_logic_vector(31 downto 0) := (others => '0');
    signal w1_reg, w2_reg, w3_reg : std_logic_vector(31 downto 0) := (others => '0');
    signal result : std_logic_vector(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ANN
        port map (
            input1 => input1,
            input2 => input2,
            w1_reg => w1_reg,
            w2_reg => w2_reg,
            w3_reg => w3_reg,
            result => result
        );

    -- Test process
    stim_proc: process
    begin
        -- Test case 1
        input1 <= std_logic_vector(to_unsigned(5, 32));
        input2 <= std_logic_vector(to_unsigned(3, 32));
        w1_reg <= std_logic_vector(to_unsigned(2, 32));
        w2_reg <= std_logic_vector(to_unsigned(4, 32));
        w3_reg <= std_logic_vector(to_unsigned(3, 32));
        wait for 10 ns;

        -- Test case 2
        input1 <= std_logic_vector(to_unsigned(10, 32));
        input2 <= std_logic_vector(to_unsigned(6, 32));
        w1_reg <= std_logic_vector(to_unsigned(1, 32));
        w2_reg <= std_logic_vector(to_unsigned(2, 32));
        w3_reg <= std_logic_vector(to_unsigned(5, 32));
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
