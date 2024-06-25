-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sub is
    Port ( 
        a : in  std_logic;
        b : in  std_logic;
        diff : out  std_logic;
        borrow : out  std_logic
    );
end sub;

architecture Behavioral of sub is
begin
    process(a, b)
    begin
        diff <= a xor b;
        borrow <= not a and b;
    end process;
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal a, b : std_logic;
    signal diff, borrow : std_logic;
    constant CLK_PERIOD : time := 10 ns;  -- Simulation clock period

begin
    -- Stimulus process
    stim_proc: process
    begin
        a <= '0';
        b <= '0';
        wait for CLK_PERIOD;
        
        for i in 0 to 3 loop
            a <= std_logic(to_unsigned(i, a'length));
            for j in 0 to 3 loop
                b <= std_logic(to_unsigned(j, b'length));
                wait for CLK_PERIOD;
            end loop;
        end loop;
        
        wait;
    end process;

    -- Instance of sub module
    sub_inst: entity work.sub
        port map (
            a => a,
            b => b,
            diff => diff,
            borrow => borrow
        );

    -- Monitor process
    monitor_proc: process
    begin
        wait for CLK_PERIOD;
        report "Time = " & integer'image(to_integer(unsigned(clock))) &
               " a = " & std_logic'image(a) &
               " b = " & std_logic'image(b) &
               " diff = " & std_logic'image(diff) &
               " borrow = " & std_logic'image(borrow);
        wait;
    end process;

end Behavioral;
