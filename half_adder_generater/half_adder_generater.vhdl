-- Half Adder (ha) Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ha is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sum : out  STD_LOGIC;
           cout : out  STD_LOGIC
         );
end ha;

architecture Behavioral of ha is
begin
    process(a, b)
    begin
        sum <= a xor b;
        cout <= a and b;
    end process;
end Behavioral;


-- Generator (gen) Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gen is
    Generic (
        N : integer := 4
    );
    Port (
        a : in  STD_LOGIC_VECTOR(N-1 downto 0);
        b : in  STD_LOGIC_VECTOR(N-1 downto 0);
        sum : out  STD_LOGIC_VECTOR(N-1 downto 0);
        cout : out  STD_LOGIC_VECTOR(N-1 downto 0)
    );
end gen;

architecture Behavioral of gen is
begin
    gen_proc: process
    begin
        genvar i;
        for i in 0 to N-1 loop
            ha_inst: ha port map (
                a => a(i),
                b => b(i),
                sum => sum(i),
                cout => cout(i)
            );
        end loop;
    end process gen_proc;
end Behavioral;


-- Testbench (tb)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    constant N : integer := 4;
    signal a, b : STD_LOGIC_VECTOR(N-1 downto 0);
    signal sum, cout : STD_LOGIC_VECTOR(N-1 downto 0);

    -- Clock process for testbench
    signal clk : STD_LOGIC := '0';
    constant CLK_PERIOD : time := 10 ns;
    constant HALF_CLK_PERIOD : time := CLK_PERIOD / 2;
begin
    -- Clock generation process
    clk_proc: process
    begin
        wait for HALF_CLK_PERIOD;
        clk <= not clk;
    end process;

    -- Stimulus process for testbench
    stim_proc: process
    begin
        a <= (others => '0');
        b <= (others => '0');
        wait for CLK_PERIOD;
        
        a <= "0010";
        b <= "0011";
        wait for CLK_PERIOD * 2;

        b <= "0100";
        wait for CLK_PERIOD;
        
        a <= "0101";
        wait;
    end process;

    -- Monitor process for displaying signals
    monitor_proc: process
    begin
        wait for CLK_PERIOD;
        report "Time = " & integer'image(to_integer(unsigned(clock))) &
               " a = " & std_logic_vector'image(a) &
               " b = " & std_logic_vector'image(b) &
               " sum = " & std_logic_vector'image(sum) &
               " cout = " & std_logic_vector'image(cout);
        wait;
    end process;

end Behavioral;
