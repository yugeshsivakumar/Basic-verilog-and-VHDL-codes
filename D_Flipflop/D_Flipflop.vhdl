-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity d_ff is
    Port ( in   : in  STD_LOGIC; -- Input data
           clk  : in  STD_LOGIC; -- Clock signal
           rst  : in  STD_LOGIC; -- Reset signal
           q    : out STD_LOGIC; -- Output data
           qb   : out STD_LOGIC  -- Complement of output data
         );
end d_ff;

architecture Behavioral of d_ff is
begin

process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            q <= '0'; -- Reset output to 0
        else
            q <= in;  -- Set output to input
        end if;
        qb <= not q; -- Complement of output
    end if;
end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal in   : STD_LOGIC := '0'; -- Input data signal
    signal clk  : STD_LOGIC := '0'; -- Clock signal
    signal rst  : STD_LOGIC := '1'; -- Reset signal
    signal q    : STD_LOGIC;        -- Output data signal
    signal qb   : STD_LOGIC;        -- Complement of output data signal
    signal i    : integer := 0;     -- Loop index for simulation

    -- Component declaration for the d_ff module
    component d_ff
        Port ( in   : in  STD_LOGIC;
               clk  : in  STD_LOGIC;
               rst  : in  STD_LOGIC;
               q    : out STD_LOGIC;
               qb   : out STD_LOGIC
             );
    end component;

begin

    -- Instantiate the d_ff module
    uut: d_ff port map (in => in, clk => clk, rst => rst, q => q, qb => qb);

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;

    -- Stimulus process to generate test patterns
    stim_proc: process
    begin
        -- Display header for better readability of simulation results
        report "Time = " & integer'image(now) & "  Reset = " & std_logic'image(rst) & "  In = " & std_logic'image(in) & "  Q = " & std_logic'image(q) & "  Qb = " & std_logic'image(qb);
        
        -- Deassert reset after 5 ns
        wait for 5 ns;
        rst <= '0';
        
        -- Generate random input signals and observe the output
        for i in 0 to 4 loop
            in <= std_logic'val(to_integer(unsigned(std_logic_vector(to_unsigned(integer'val(random(1)), 1)))));
            wait for 5 ns;
        end loop;
        
        -- Reassert reset signal and continue random input generation
        for i in 0 to 4 loop
            in <= std_logic'val(to_integer(unsigned(std_logic_vector(to_unsigned(integer'val(random(1)), 1)))));
            rst <= '1';
            wait for 5 ns;
            rst <= '0';
        end loop;
        
        wait for 50 ns;
        report "Simulation finished.";
        wait;
    end process;

end Behavioral;